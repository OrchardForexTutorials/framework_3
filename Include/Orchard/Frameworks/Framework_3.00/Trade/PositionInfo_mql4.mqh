/*

	PositionInfo_mql4.mqh
	
   Copyright 2013-2022, Orchard Forex
   https://www.orchardforex.com

*/

#property copyright "Copyright 2021, Orchard Forex"
#property link      "https://orchardforex.com"
#property version   "1.01"
#property strict

#include "../Framework_Version.mqh"
#include "../Common/Defines.mqh"

class CPositionInfo {

public:

	bool					SelectByIndex(int index);

	int					Magic()				{	return(OrderMagicNumber());	}
	ENUM_POSITION_TYPE	PositionType()	{	return((ENUM_POSITION_TYPE)OrderType());	}
	double				PriceOpen()			{	return(OrderOpenPrice());	}
	double				StopLoss()			{	return(OrderStopLoss());	}
	string				Symbol()				{	return(OrderSymbol());		}
	double				TakeProfit()		{	return(OrderTakeProfit());	}
	int					Ticket()				{	return(OrderTicket());		}

};

/*
*	CPositionInfoCustom::SelectByIndex
*	Select an order by indexed position
*	@param - index : index position of order to select
*	@return - ticket number : 0 if the order is not buy/sell or is closed or not found
*/
bool	CPositionInfo::SelectByIndex(int index) {

	if ( !OrderSelect(index, SELECT_BY_POS, MODE_TRADES) ) return(false);
	if ( OrderType()!=ORDER_TYPE_BUY && OrderType()!=ORDER_TYPE_SELL ) return(false);
	if ( OrderCloseTime() > 0 ) return(false);
	return(OrderTicket()>0);
	
}

class CPositionInfoCustom : public CPositionInfo {

public:

	int					Total()				{	return(OrdersTotal());	}

};