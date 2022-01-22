/*

	Framework Example 3.00.1.mq5
	
   Copyright 2013-2022, Orchard Forex
   https://www.orchardforex.com

*/

#property copyright "Copyright 2022, Orchard Forex"
#property link      "https://orchardforex.com"
#property version   "1.00"

#include <Orchard/Frameworks/Framework_3.00/Framework.mqh>

#define	CExpert	CExpertBase
CExpert*	Expert;

int OnInit(void) {

	Expert	=	new CExpert();

	return(Expert.OnInit());
		
}

void OnDeinit(const int reason) {

	Expert.OnDeinit(reason);
	
	delete	Expert;
	
}

void OnTick(void) {

	Expert.OnTick();
	
}

