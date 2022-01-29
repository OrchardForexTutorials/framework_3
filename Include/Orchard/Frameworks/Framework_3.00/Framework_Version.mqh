/*
 	Framework_version.mqh
 	Framework 3.00
 	
   Copyright 2013-2022, Orchard Forex
   https://www.orchardforex.com
 
 	all of thenumbers here are 3.nn or 3_nn
 	just global replace nn with mm to update to a new version
 	
*/

#ifdef _FRAMEWORK_VERSION_3_00

	#ifndef _FRAMEWORK_VERSION_
		#define _FRAMEWORK_VERSION_ "3.00"
	#endif

#endif 

#ifndef _FRAMEWORK_VERSION_

	#define _FRAMEWORK_VERSION_ "3.00"
	//	Make sure the define is correct for the selected version
	#ifndef _FRAMEWORK_VERSION_3_00
		#define _FRAMEWORK_VERSION_3_00
	#endif 

#endif
	
