/*
   ExpertBase.mqh
   Framework 3.01

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

#include "../Common/CommonBase.mqh"
#include "../Common/Defines.mqh"
#include "../Trade/Trade.mqh"

class CExpertBase : public CCommonBase {

private:
protected:
   CTradeCustom        Trade;
   CPositionInfoCustom PositionInfo;

   double              mOrderSize;
   string              mTradeComment;
   long                mMagic;

   bool                mFirstTime;
   MqlTick             mLastTick;

   virtual void        CloseAll( ENUM_POSITION_TYPE type, double price );
   virtual void        Setup() { return; }
   virtual void        Loop() { return; }

public:
   CExpertBase();
   CExpertBase( double orderSize, string tradeComment, long magic );
   ~CExpertBase() {}

   virtual int  OnInit() { return ( INIT_SUCCEEDED ); }
   virtual void OnDeinit( const int reason ) { return; }
   virtual void OnTick();

   bool         TradeAllowed();
};

CExpertBase::CExpertBase() { CExpertBase( 0, "", 0 ); }

CExpertBase::CExpertBase( double orderSize, string tradeComment, long magic ) {

   mOrderSize    = orderSize;
   mTradeComment = tradeComment;
   mMagic        = magic;

   Trade.SetExpertMagicNumber( magic );

   mFirstTime = true;
}

void CExpertBase::OnTick() {

   // is trading allowed
   if ( !TradeAllowed() ) return;

   //	Just the first time
   //	Here because this is where we have data loaded
   if ( mFirstTime ) {
      Setup();
   }

   if ( !SymbolInfoTick( mSymbol, mLastTick ) ) return; //	If no data available exit and try again

   Loop();
}

bool CExpertBase::TradeAllowed() {

   //	Some general get out early conditions
   return ( TerminalInfoInteger( TERMINAL_TRADE_ALLOWED ) && MQLInfoInteger( MQL_TRADE_ALLOWED ) &&
            AccountInfoInteger( ACCOUNT_TRADE_EXPERT ) &&
            AccountInfoInteger( ACCOUNT_TRADE_ALLOWED ) );
}
