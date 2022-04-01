/*
 *	IndicatorMACD.mqh
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

class CIndicatorMACD : public CIndicatorBase {

private:
protected: // member variables
   int                mFastPeriod;
   int                mSlowPeriod;
   int                mSignalPeriod;
   ENUM_APPLIED_PRICE mAppliedPrice;

   void Init( int fastPeriod, int slowPeriod, int signalPeriod, ENUM_APPLIED_PRICE appliedPrice );

public: // constructors
   CIndicatorMACD( int fastPeriod, int slowPeriod, int signalPeriod,
                   ENUM_APPLIED_PRICE appliedPrice );
   CIndicatorMACD( string symbol, ENUM_TIMEFRAMES timeframe, // Normally default to chart
                   int fastPeriod, int slowPeriod, int signalPeriod,
                   ENUM_APPLIED_PRICE appliedPrice );
   ~CIndicatorMACD();

public:
#ifdef __MQL4__
   virtual double GetData( const int buffer_num, const int index );
#endif
};

CIndicatorMACD::CIndicatorMACD( int fastPeriod, int slowPeriod, int signalPeriod,
                                ENUM_APPLIED_PRICE appliedPrice )
   : CIndicatorBase( Symbol(), ( ENUM_TIMEFRAMES )Period() ) {

   Init( fastPeriod, slowPeriod, signalPeriod, appliedPrice );
}

CIndicatorMACD::CIndicatorMACD( string symbol, ENUM_TIMEFRAMES timeframe, //
                                int fastPeriod, int slowPeriod, int signalPeriod,
                                ENUM_APPLIED_PRICE appliedPrice )
   : CIndicatorBase( symbol, timeframe ) {

   Init( fastPeriod, slowPeriod, signalPeriod, appliedPrice );
}

void CIndicatorMACD::Init( int fastPeriod, int slowPeriod, int signalPeriod,
                           ENUM_APPLIED_PRICE appliedPrice ) {

   if ( mInitResult != INIT_SUCCEEDED ) return;

   mFastPeriod   = fastPeriod;
   mSlowPeriod   = slowPeriod;
   mSignalPeriod = signalPeriod;
   mAppliedPrice = appliedPrice;

//	For MQL5 create the indicator handle here
#ifdef __MQL5__
   mIndicatorHandle =
      iMACD( mSymbol, mTimeframe, mFastPeriod, mSlowPeriod, mSignalPeriod, mAppliedPrice );
   if ( mIndicatorHandle == INVALID_HANDLE ) {
      InitError( "Failed to create indicator handle", INIT_FAILED );
      return;
   }
#endif

   InitError( "", INIT_SUCCEEDED );
}

CIndicatorMACD::~CIndicatorMACD() {}

#ifdef __MQL4__
double CIndicatorMACD::GetData( const int buffer_num, const int index ) {

   double value = iMACD( mSymbol, mTimeframe, mFastPeriod, mSlowPeriod, mSignalPeriod,
                         mAppliedPrice, buffer_num, index );
   return ( value );
}
#endif