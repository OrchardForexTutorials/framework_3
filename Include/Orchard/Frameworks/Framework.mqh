/* 
 	Framework.mqh 
 	 
   Copyright 2013-2022, Orchard Forex 
   https://www.orchardforex.com 
 
 
*/ 
 
// 
//	The only purpose of this mqh file is to provide a single 
//		point to change the current framework version 
// 
//	If you place an include to this file in your code you 
//		will get the version framework defined in this file 
//		unless your code has already included another 
//		framework file 

//	If no framework version has been selected then default to the current here
#ifndef	_FRAMEWORK_VERSION_ 
	#define _FRAMEWORK_VERSION_ "3.00"
	//	Make sure the define is correct for the selected version
	#ifndef _FRAMEWORK_VERSION_3_00
		#define _FRAMEWORK_VERSION_3_00
	#endif 
#endif 

//	The following will load in the selected framework
//	If you have selected an invalid framework you will just get nothing
#ifdef _FRAMEWORK_VERSION_3_00
	#include "Framework_3.00/Framework.mqh"
#endif

