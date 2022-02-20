/*
   Framework.mqh

   Copyright 2013-2022, Orchard Forex
   https://www.orchardforex.com


*/

/**=
 *
 * Disclaimer and Licence
 *
 * This file is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 *
 * All trading involves risk. You should have received the risk warnings
 * and terms of use in the README.MD file distributed with this software.
 * See the README.MD file for more information and before using this software.
 *
 **/

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

// 3.03 introduced indicator classes
#include "Framework_3.03/Framework.mqh"
#include "Framework_3.02/Framework.mqh"
#include "Framework_3.01/Framework.mqh"
#include "Framework_3.00/Framework.mqh"
