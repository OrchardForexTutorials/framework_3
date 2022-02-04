/*
 	ExpertBase.mqh
 	Framework 3.01
 	
   Copyright 2013-2022, Orchard Forex
   https://www.orchardforex.com
 
*/

#include "../Common/Defines.mqh"
#include "../Common/CommonBase.mqh"
#include "../Trade/Trade.mqh"

class CExpertBase : public CCommonBase {

private:

protected:

	CTradeCustom			Trade;
	CPositionInfoCustom	PositionInfo;

	double					mOrderSize;
	string					mTradeComment;
	long						mMagic;
	
	int						mCount;
	bool						mFirstTime;
	MqlTick					mLastTick;
	bool						mNewBar;
	datetime					mPrevBarTime;

	virtual void			CloseAll(ENUM_POSITION_TYPE type, double price);
	virtual void			Setup()		{	return;	}
	virtual void			Loop()		{	return;	}
	bool						NewBar();
	virtual void			Recount();

public:

	CExpertBase();
	CExpertBase(double orderSize, string tradeComment, long magic);
	~CExpertBase() {}
	
	virtual int		OnInit()							{	return(INIT_SUCCEEDED);	}
	virtual void	OnDeinit(const int reason)	{	return;	}
	virtual void	OnTick();
	
	bool					TradeAllowed();
	
};

CExpertBase::CExpertBase() {

	CExpertBase(0, "", 0);

}

CExpertBase::CExpertBase(double orderSize, string tradeComment, long magic) {

	mOrderSize		=	orderSize;
	mTradeComment	=	tradeComment;
	mMagic			=	magic;

	Trade.SetExpertMagicNumber(magic);
	
	mFirstTime		=	true;
	mPrevBarTime	=	0;

}

void	CExpertBase::OnTick() {

	// is trading allowed
	if (!TradeAllowed()) return;

	//	Just the first time
	//	Here because this is where we have data loaded
	if (mFirstTime) {

		Setup();	

	}

	if (!SymbolInfoTick(mSymbol, mLastTick)) return;	//	If no data available exit and try again
	
	mNewBar	=	NewBar();

	Loop();
	
}

bool		CExpertBase::NewBar() {

	datetime	currentBarTime	=	iTime(mSymbol, mTimeframe, 0);
	if (currentBarTime==mPrevBarTime) {
		return(false);
	}
	mPrevBarTime				=	currentBarTime;
	return(true);
	
}

/*
 *	Recount()
 *
 *	Scans currently open trades and rebuilds the position
 */
void		CExpertBase::Recount() {

	mCount					=	0;
	
	for (int i=PositionInfo.Total()-1; i>=0; i--) {
		
		if (!PositionInfo.SelectByIndex(i)) continue;
		
		if (PositionInfo.Symbol()!=mSymbol || PositionInfo.Magic()!=mMagic) continue;

		mCount++;

	}

}

bool	CExpertBase::TradeAllowed() {

	//	Some general get out early conditions
	return(	TerminalInfoInteger(TERMINAL_TRADE_ALLOWED)
				&&	MQLInfoInteger(MQL_TRADE_ALLOWED)
				&&	AccountInfoInteger(ACCOUNT_TRADE_EXPERT)
				&&	AccountInfoInteger(ACCOUNT_TRADE_ALLOWED)
				);
	
}







