//
// Time Filter Class
// takes a time range in HH:MM format to allow trades
//

class CTimeFilter {

private:

protected:

   bool        UseStartFinish;
   string      mStartTime;
   string      mStopTime;
   int         StartMinutes;
   int         StopMinutes;
   
   bool        ValidateTimeString( string timeString, int &timeMinutes );
   bool        StrToTimeInteger( string text, int min, int max, int &value );
   int         TimeToMinutes( datetime time );  

public:

   CTimeFilter( string startTime, string stopTime );
   ~CTimeFilter();
   
   bool        ValidateString();
   bool        isInsideRange( datetime now );

};


CTimeFilter::CTimeFilter(string startTime,string stopTime) {

   mStartTime  = startTime;
   mStopTime   = stopTime;

}

CTimeFilter::~CTimeFilter(void) {

}


int CTimeFilter::TimeToMinutes(datetime time) {

   MqlDateTime mtime;
   TimeToStruct( time, mtime );
   return ( mtime.hour * 60 + mtime.min );

}


bool CTimeFilter::isInsideRange( datetime now ) {

   if ( !UseStartFinish)   return false;
   
   int nowMinutes = TimeToMinutes( now );
   
   return ( ( StartMinutes <= nowMinutes && nowMinutes < StopMinutes ) || 
          ( ( StartMinutes > StopMinutes ) && 
            ( nowMinutes >= StartMinutes || nowMinutes < StopMinutes ) ) );

}


//
// Validate strings provided for time filter
//
bool CTimeFilter::ValidateString() {

   if ( mStartTime == "" && mStopTime == "" ) {
      UseStartFinish = false;
      return true;
   }
   
   if ( !ValidateTimeString( mStartTime, StartMinutes ) ) {
      PrintFormat("Start time %s is invalid, Select a valid time in the format HH:MM", mStartTime );
      return false;
   }
   
   if ( !ValidateTimeString( mStopTime, StopMinutes ) ) {
      PrintFormat("Finish time %s is invalid, Select a valid time in the format HH:MM", mStopTime );
      return false;
   }
   
   UseStartFinish = ( StartMinutes != StopMinutes );
   return true;

}



bool CTimeFilter::ValidateTimeString( string timeString, int &timeMinutes ) {

   string timeParts[];
   if ( !(StringSplit( timeString, ':', timeParts ) == 2) ) {
      return false;
   }
   
   int hours;
   int minutes;
   
   if ( !StrToTimeInteger( timeParts[0], 0, 23, hours ) ) {
      return false;
   }
   
   if ( !StrToTimeInteger( timeParts[1], 0, 59, minutes ) ) {
      return false;
   }
   timeMinutes = ( hours * 60 + minutes );
   return true;

}



bool CTimeFilter::StrToTimeInteger( string text, int min, int max, int &value ) {

   value = ( int )StringToInteger( text );
   if ( value < min || value > max )   return false;
   
   string test = IntegerToString( value );
   if ( StringLen( text ) > StringLen( test ) ) {
      string zero;
      StringInit( zero, StringLen( text ) - StringLen( test ), '0' );
      test = zero + test;
   }
   
   return ( test == text );   // make sure the round trip gives the same result

}

