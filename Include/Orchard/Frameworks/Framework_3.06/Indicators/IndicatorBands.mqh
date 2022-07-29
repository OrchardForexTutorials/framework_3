/*
 *	IndicatorBands.mqh
 *
 *	Copyright 2022, Orchard Forex
 *	https://orchardforex.com
 *
 */

#include "IndicatorBase.mqh"

class CIndicatorBands : public CIndicatorBase {

private:

protected: // member variables
   int                mPeriod;
   double             mDeviation;
   ENUM_APPLIED_PRICE mAppliedPrice;

   void               Init( int period, double deviation, ENUM_APPLIED_PRICE appliedPrice );

public: // constructors
   CIndicatorBands( int period, double deviation, ENUM_APPLIED_PRICE appliedPrice );
   CIndicatorBands( string symbol, ENUM_TIMEFRAMES timeframe, int period, double deviation, ENUM_APPLIED_PRICE appliedPrice );
   ~CIndicatorBands();

public:

};

CIndicatorBands::CIndicatorBands( int period, double deviation, ENUM_APPLIED_PRICE appliedPrice ) : CIndicatorBase( Symbol(), ( ENUM_TIMEFRAMES )Period() ) {
   Init( period, deviation, appliedPrice );
}

CIndicatorBands::CIndicatorBands( string symbol, ENUM_TIMEFRAMES timeframe, int period, double deviation, ENUM_APPLIED_PRICE appliedPrice ) : CIndicatorBase( symbol, timeframe ) {
   Init( period, deviation, appliedPrice );
}

void CIndicatorBands::Init( int period, double deviation, ENUM_APPLIED_PRICE appliedPrice ) {

   if ( mInitResult != INIT_SUCCEEDED ) return;

   mPeriod       = period;
   mDeviation    = deviation;
   mAppliedPrice = appliedPrice;

//	For MQL5 create the indicator handle here

   mIndicatorHandle = iBands( mSymbol, mTimeframe, mPeriod, 0, mDeviation, mAppliedPrice );
   if ( mIndicatorHandle == INVALID_HANDLE ) {
      InitError( "Failed to create indicator handle", INIT_FAILED );
      return;
   }

   InitError( "", INIT_SUCCEEDED );
}

CIndicatorBands::~CIndicatorBands() {}