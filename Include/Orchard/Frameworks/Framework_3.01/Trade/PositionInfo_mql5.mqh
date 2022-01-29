/*
 	PositionInfo_mql5.mqh
 	Framework 3.01
 	
   Copyright 2013-2022, Orchard Forex
   https://www.orchardforex.com
 
*/
 
#include	<Trade/PositionInfo.mqh>

class CPositionInfoCustom : public CPositionInfo {

public:

	int	Total()	{	return(PositionsTotal());	}

};

