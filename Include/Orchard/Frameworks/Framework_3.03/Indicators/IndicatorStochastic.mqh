/*
 *	IndicatorStochastic.mqh
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

class CIndicatorStochastic : public CIndicatorBase
{

private:
protected: // member variables
   int            mKPeriod;
   int            mDPeriod;
   int            mSlowing;
   ENUM_MA_METHOD mStoMethod;
   ENUM_STO_PRICE mStoPrice;

public: // constructors
   CIndicatorStochastic( int kPeriod, int dPeriod, int slowing, ENUM_MA_METHOD stoMethod,
                         ENUM_STO_PRICE stoPrice );
   CIndicatorStochastic( string symbol, ENUM_TIMEFRAMES timeframe, int kPeriod, int dPeriod,
                         int slowing, ENUM_MA_METHOD stoMethod, ENUM_STO_PRICE stoPrice );
   ~CIndicatorStochastic();

public:
   virtual double GetData( const int buffer_num, const int index );
};

CIndicatorStochastic::CIndicatorStochastic( int kPeriod, int dPeriod, int slowing,
                                            ENUM_MA_METHOD stoMethod, ENUM_STO_PRICE stoPrice ) {

   CIndicatorStochastic( Symbol(), ( ENUM_TIMEFRAMES )Period(), kPeriod, dPeriod, slowing,
                         stoMethod, stoPrice );
}

CIndicatorStochastic::CIndicatorStochastic( string symbol, ENUM_TIMEFRAMES timeframe, int kPeriod,
                                            int dPeriod, int slowing, ENUM_MA_METHOD stoMethod,
                                            ENUM_STO_PRICE stoPrice )
   : CIndicatorBase( symbol, timeframe ) {

   if ( mInitResult != INIT_SUCCEEDED ) return;

   mKPeriod   = kPeriod;
   mDPeriod   = dPeriod;
   mSlowing   = slowing;
   mStoMethod = stoMethod;
   mStoPrice  = stoPrice;

//	For MQL5 create the indicator handle here
#ifdef __MQL5__
   mIndicatorHandle =
      iStochastic( mSymbol, mTimeframe, mKPeriod, mDPeriod, mSlowing, mStoMethod, mStoPrice );
   if ( mIndicatorHandle == INVALID_HANDLE ) {
      InitError( "Failed to create indicator handle", INIT_FAILED );
      return;
   }
#endif

   InitError( "", INIT_SUCCEEDED );
}

CIndicatorStochastic::~CIndicatorStochastic() {}

double CIndicatorStochastic::GetData( const int buffer_num, const int index ) {

   double value = 0;

// Get the value directly for MQL4
#ifdef __MQL4__
   value = iStochastic( mSymbol, mTimeframe, mKPeriod, mDPeriod, mSlowing, mStoMethod, mStoPrice,
                        buffer_num, index );
#endif

//	Get data from a buffer for MQL5
//	Improve all of this later when there is a need for an array of results
#ifdef __MQL5__
   double bufferData[];
   ArraySetAsSeries( bufferData, true );
   int cnt = CopyBuffer( mIndicatorHandle, buffer_num, index, 1, bufferData );
   if ( cnt > 0 ) value = bufferData[0];
#endif

   return ( value );
}
