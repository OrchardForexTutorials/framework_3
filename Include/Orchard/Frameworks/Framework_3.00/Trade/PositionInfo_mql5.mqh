/*
 	Trade.mqh
 	(For MQL5)
 	
   Copyright 2013-2022, Orchard Forex
   https://www.orchardforex.com
 
*/
 
#include	<Trade/PositionInfo.mqh>

class CPositionInfoCustom : public CPositionInfo {

public:

	int	Total()	{	return(PositionsTotal());	}

};

