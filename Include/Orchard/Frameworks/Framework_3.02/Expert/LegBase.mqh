/*
 	LegBase.mqh
 	Framework 3.01
 	
   Copyright 2013-2022, Orchard Forex
   https://www.orchardforex.com
 
*/

#include "ExpertBase.mqh"

class CLegBase : public CExpertBase {

private:


protected:

	ENUM_POSITION_TYPE	mLegType;
	
public:

	CLegBase(ENUM_POSITION_TYPE legType, double orderSize, string tradeComment, long magic);
	~CLegBase() {}
	
	
};

CLegBase::CLegBase(ENUM_POSITION_TYPE legType, double orderSize, string tradeComment, long magic)
							:	CExpertBase(orderSize, tradeComment, magic) {

	mLegType		=	legType;

}


