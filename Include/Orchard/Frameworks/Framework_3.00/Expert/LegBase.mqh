/*
   ExpertBase.mqh
   Framework version 3.00

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

#include "../Framework_Version.mqh"

#include "../Common/CommonBase.mqh"
#include "../Common/Defines.mqh"

class CExpertBase : public CCommonBase {

private:
protected:
public:
   CExpertBase() {}
   ~CExpertBase() {}

   virtual int  OnInit() { return ( INIT_SUCCEEDED ); }
   virtual void OnDeinit( const int reason ) { return; }
   virtual void OnTick() { return; }
};
