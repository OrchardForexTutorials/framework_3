/*
   IndicatorHA.mqh

   Copyright 2022, Orchard Forex
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
#include "IndicatorBase.mqh"

#ifdef __MQL4__
#define HAIndicator "Indicators\\Heiken Ashi.ex4"
#endif
#ifdef __MQL5__
#define HAIndicator "Indicators\\Examples\\Heiken_Ashi.ex5"
#endif
#resource "\\" + HAIndicator

enum ENUM_HA_BUFFER
{
#ifdef __MQL4__
   HA_BUFFER_LOHI,
   HA_BUFFER_HILO,
   HA_BUFFER_OPEN,
   HA_BUFFER_CLOSE,
#endif
#ifdef __MQL5__
   HA_BUFFER_OPEN,
   HA_BUFFER_HILO,
   HA_BUFFER_LOHI,
   HA_BUFFER_CLOSE,
#endif
};

class CIndicatorHA : public CIndicatorBase
{

private:
protected: // member variables
   void Init();

public: // constructors
   CIndicatorHA();
   CIndicatorHA( string symbol, ENUM_TIMEFRAMES timeframe );
   ~CIndicatorHA();

public:
#ifdef __MQL4__
   virtual double GetData( const int buffer_num, const int index );
#endif
};

CIndicatorHA::CIndicatorHA() : CIndicatorBase( Symbol(), ( ENUM_TIMEFRAMES )Period() ) { Init(); }

CIndicatorHA::CIndicatorHA( string symbol, ENUM_TIMEFRAMES timeframe )
   : CIndicatorBase( symbol, timeframe ) {

   Init();
}

void CIndicatorHA::Init() {

   if ( mInitResult != INIT_SUCCEEDED ) return;

//	For MQL5 create the indicator handle here
#ifdef __MQL5__
   mIndicatorHandle = iCustom( mSymbol, mTimeframe, "::" + HAIndicator );
   if ( mIndicatorHandle == INVALID_HANDLE ) {
      InitError( "Failed to create indicator handle", INIT_FAILED );
      return;
   }
#endif

   InitError( "", INIT_SUCCEEDED );
}

CIndicatorHA::~CIndicatorHA() {}

#ifdef __MQL4__
double CIndicatorHA::GetData( const int buffer_num, const int index ) {

   return ( iCustom( mSymbol, mTimeframe, "::" + HAIndicator, buffer_num, index ) );
}
#endif
