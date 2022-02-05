/*
 	Framework_version.mqh
 	Framework 3.00
 	
   Copyright 2013-2022, Orchard Forex
   https://www.orchardforex.com
 
 	all of thenumbers here are 3.nn or 3_nn
 	just global replace nn with mm to update to a new version
 	
*/

/** Disclaimer and Licence

 *	This file is free software: you can redistribute it and/or modify
 *	it under the terms of the GNU General Public License as published by
 *	the Free Software Foundation, either version 3 of the License, or
 *	(at your option) any later version.

 *	This program is distributed in the hope that it will be useful,
 *	but WITHOUT ANY WARRANTY; without even the implied warranty of
 *	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *	GNU General Public License for more details.
 
 *	You should have received a copy of the GNU General Public License
 *	along with this program.  If not, see <http://www.gnu.org/licenses/>.

 *	All trading involves risk. You should have received the risk warnings
 *	and terms of use in the README.MD file distributed with this software.
 *	See the README.MD file for more information and before using this software.

 **/

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
	
