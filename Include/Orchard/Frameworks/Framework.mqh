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

//	The following will load in the selected framework
//		beginning with the latest
//	If you have selected a framework with (need both lines in the beginning of your app)
//			#define FRAMEWORK_VERSION_3_XX_
//			#define FRAMEWORK_VERSION
//		then that version will be loaded. If not the most recent
//		is loaded


#include "Framework_3.01/Framework.mqh"
#include "Framework_3.00/Framework.mqh"

