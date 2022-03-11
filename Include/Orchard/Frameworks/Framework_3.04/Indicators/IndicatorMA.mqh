/*
 *	IndicatorMA.mqh
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

class CIndicatorMA : public CIndicatorBase
{

private:
protected: // member variables
   int                mPeriod;
   ENUM_MA_METHOD     mMethod;
   ENUM_APPLIED_PRICE mAppliedPrice;

   void               Init( int period, ENUM_MA_METHOD method, ENUM_APPLIED_PRICE appliedPrice );

public: // constructors
   CIndicatorMA( int period, ENUM_MA_METHOD method, ENUM_APPLIED_PRICE appliedPrice );
   CIndicatorMA( string symbol, ENUM_TIMEFRAMES timeframe, int period, ENUM_MA_METHOD method,
                 ENUM_APPLIED_PRICE appliedPrice );
   ~CIndicatorMA();

public:
#ifdef __MQL4__
   virtual double GetData( const int buffer_num, const int index );
#endif
};

CIndicatorMA::CIndicatorMA( int period, ENUM_MA_METHOD method, ENUM_APPLIED_PRICE appliedPrice )
   : CIndicatorBase( Symbol(), ( ENUM_TIMEFRAMES )Period() ) {

   Init( period, method, appliedPrice );
}

CIndicatorMA::CIndicatorMA( string symbol, ENUM_TIMEFRAMES timeframe, int period,
                            ENUM_MA_METHOD method, ENUM_APPLIED_PRICE appliedPrice )
   : CIndicatorBase( symbol, timeframe ) {

   Init( period, method, appliedPrice );
}

void CIndicatorMA::Init( int period, ENUM_MA_METHOD method, ENUM_APPLIED_PRICE appliedPrice ) {

   if ( mInitResult != INIT_SUCCEEDED ) return;

   mPeriod       = period;
   mMethod       = method;
   mAppliedPrice = appliedPrice;

//	For MQL5 create the indicator handle here
#ifdef __MQL5__
   mIndicatorHandle = iMA( mSymbol, mTimeframe, mPeriod, 0, mMethod, mAppliedPrice );
   if ( mIndicatorHandle == INVALID_HANDLE ) {
      InitError( "Failed to create indicator handle", INIT_FAILED );
      return;
   }
#endif

   InitError( "", INIT_SUCCEEDED );
}

CIndicatorMA::~CIndicatorMA() {}

#ifdef __MQL4__
double CIndicatorMA::GetData( const int buffer_num, const int index ) {

   double value = iMA( mSymbol, mTimeframe, mPeriod, 0, mMethod, mAppliedPrice, index );
   return ( value );
}
#endif