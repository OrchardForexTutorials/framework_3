/*
 *	IndicatorRSI.mqh
 *
 *	Copyright 2022, Orchard Forex
 *	https://orchardforex.com
 *
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

class CIndicatorRSI : public CIndicatorBase {

private:
protected: // member variables
   int                mPeriod;
   ENUM_MA_METHOD     mMethod;
   ENUM_APPLIED_PRICE mAppliedPrice;

   void               Init( int period, ENUM_APPLIED_PRICE appliedPrice );

public: // constructors
   CIndicatorRSI( int period, ENUM_APPLIED_PRICE appliedPrice );
   CIndicatorRSI( string symbol, ENUM_TIMEFRAMES timeframe, int period,
                  ENUM_APPLIED_PRICE appliedPrice );
   ~CIndicatorRSI();

public:
#ifdef __MQL4__
   virtual double GetData( const int buffer_num, const int index );
#endif
};

CIndicatorRSI::CIndicatorRSI( int period, ENUM_APPLIED_PRICE appliedPrice )
   : CIndicatorBase( Symbol(), ( ENUM_TIMEFRAMES )Period() ) {

   Init( period, appliedPrice );
}

CIndicatorRSI::CIndicatorRSI( string symbol, ENUM_TIMEFRAMES timeframe, int period,
                              ENUM_APPLIED_PRICE appliedPrice )
   : CIndicatorBase( symbol, timeframe ) {

   Init( period, appliedPrice );
}

void CIndicatorRSI::Init( int period, ENUM_APPLIED_PRICE appliedPrice ) {

   if ( mInitResult != INIT_SUCCEEDED ) return;

   mPeriod       = period;
   mAppliedPrice = appliedPrice;

//	For MQL5 create the indicator handle here
#ifdef __MQL5__
   mIndicatorHandle = iRSI( mSymbol, mTimeframe, mPeriod, mAppliedPrice );
   if ( mIndicatorHandle == INVALID_HANDLE ) {
      InitError( "Failed to create indicator handle", INIT_FAILED );
      return;
   }
#endif

   InitError( "", INIT_SUCCEEDED );
}

CIndicatorRSI::~CIndicatorRSI() {}

#ifdef __MQL4__
double CIndicatorRSI::GetData( const int buffer_num, const int index ) {

   double value = iRSI( mSymbol, mTimeframe, mPeriod, mAppliedPrice, index );
   return ( value );
}
#endif