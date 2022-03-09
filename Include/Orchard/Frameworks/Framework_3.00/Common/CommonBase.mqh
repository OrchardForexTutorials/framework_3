/*
   CommonBase.mqh
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

#include <Object.mqh>

#include "Defines.mqh"

#define _INIT_CHECK_FAIL                                                                           \
   if ( mInitResult != INIT_SUCCEEDED ) return ( mInitResult );
#define _INIT_ERROR( msg ) return ( InitError( msg, INIT_PARAMETERS_INCORRECT ) );
#define _INIT_ASSERT( condition, msg )                                                             \
   if ( !condition ) return ( InitError( msg, INIT_FAILED ) );

class CCommonBase : public CObject {

private:
protected: //	Members
   int             mDigits;
   string          mSymbol;
   ENUM_TIMEFRAMES mTimeframe;

   string          mInitMessage;
   int             mInitResult;

protected: //	Constructors
   //
   //	Constructors
   //
   CCommonBase() {
      Init( _Symbol, ( ENUM_TIMEFRAMES )_Period );
   }
   CCommonBase( string symbol ) {
      Init( symbol, ( ENUM_TIMEFRAMES )_Period );
   }
   CCommonBase( int timeframe ) {
      Init( _Symbol, ( ENUM_TIMEFRAMES )timeframe );
   }
   CCommonBase( ENUM_TIMEFRAMES timeframe ) {
      Init( _Symbol, timeframe );
   }
   CCommonBase( string symbol, int timeframe ) {
      Init( symbol, ( ENUM_TIMEFRAMES )timeframe );
   }
   CCommonBase( string symbol, ENUM_TIMEFRAMES timeframe ) {
      Init( symbol, timeframe );
   }

   //
   //	Destructors
   //
   ~CCommonBase(){};

   int Init( string symbol, ENUM_TIMEFRAMES timeframe );

protected: //	Functions
   int InitError( string initMessage, int initResult ) {
      mInitMessage = initMessage;
      mInitResult  = initResult;
      if ( initMessage != "" ) Print( initMessage );
      return ( initResult );
   }

   double PointsToDouble( int points ) {
      return ( points * SymbolInfoDouble( mSymbol, SYMBOL_POINT ) );
   }

public: //	Properties
   int InitResult() {
      return ( mInitResult );
   }
   string InitMessage() {
      return ( mInitMessage );
   }

public: //	Functions
   bool TradeAllowed() {
      return ( SymbolInfoInteger( mSymbol, SYMBOL_TRADE_MODE ) != SYMBOL_TRADE_MODE_DISABLED );
   }
};

int CCommonBase::Init( string symbol, ENUM_TIMEFRAMES timeframe ) {

   InitError( "", INIT_SUCCEEDED );

   mSymbol    = symbol;
   mTimeframe = timeframe;
   mDigits    = ( int )SymbolInfoInteger( symbol, SYMBOL_DIGITS );

   return ( INIT_SUCCEEDED );
}
