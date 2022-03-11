/*
   IndicatorBase.mqh

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
#include "../Common/CommonBase.mqh"
#include "../Common/Defines.mqh"

class CIndicatorBase : public CCommonBase
{

private:
protected: // member variables
   //	Only used for MQL5 but will not hurt MQL4 to be defined
   int mIndicatorHandle;

public: // constructors
   CIndicatorBase() : CCommonBase() { Init(); }
   CIndicatorBase( string symbol, ENUM_TIMEFRAMES timeframe ) : CCommonBase( symbol, timeframe ) {
      Init();
   }
   ~CIndicatorBase();

   int Init();

public:
   virtual double GetData( const int index ) { return ( GetData( 0, index ) ); }
   virtual double GetData( const int bufferNum, const int index );
   int            handle() { return ( mIndicatorHandle ); }
};

CIndicatorBase::~CIndicatorBase() {

#ifdef __MQL5__

   if ( mIndicatorHandle != INVALID_HANDLE ) IndicatorRelease( mIndicatorHandle );

#endif
}

int CIndicatorBase::Init() {

   if ( InitResult() != INIT_SUCCEEDED ) return ( InitResult() );

#ifdef __MQL5__
   //	Clean up here in case of a restart
   if ( mIndicatorHandle != INVALID_HANDLE ) IndicatorRelease( mIndicatorHandle );
#endif
   mIndicatorHandle = INVALID_HANDLE;

   return ( INIT_SUCCEEDED );
}

#ifdef __MQL5__
double CIndicatorBase::GetData( const int buffer_num, const int index ) {

   double value = 0;

   //	Get data from a buffer for MQL5
   //	Improve all of this later when there is a need for an array of results
   double bufferData[];
   ArraySetAsSeries( bufferData, true );
   int cnt = CopyBuffer( mIndicatorHandle, buffer_num, index, 1, bufferData );
   if ( cnt > 0 ) value = bufferData[0];

   return ( value );
}
#endif
