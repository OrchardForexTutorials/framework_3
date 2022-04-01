/*
   Trade.mqh
   (For MQL4)

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

#include <Object.mqh>

#include "../Common/Defines.mqh"

class CTrade : public CObject {

private:
protected:                 // member variables
   int            m_magic; // expert magic number
   MqlTradeResult mResult; // result data

   void           ClearStructures();

public: // constructors
   CTrade();
   ~CTrade();

public:
   ulong  RequestMagic() { return ( m_magic ); }
   void   SetExpertMagicNumber( const long magic ) { m_magic = ( int )magic; }

   double BuyPrice( string symbol ) { return ( SymbolInfoDouble( symbol, SYMBOL_ASK ) ); }
   double SellPrice( string symbol ) { return ( SymbolInfoDouble( symbol, SYMBOL_BID ) ); }

   bool   Buy( const double volume, const string symbol = NULL, double price = 0.0,
               const double sl = 0.0, const double tp = 0.0, const string comment = "" );
   bool   Sell( const double volume, const string symbol = NULL, double price = 0.0,
                const double sl = 0.0, const double tp = 0.0, const string comment = "" );

   bool   OrderOpen( const string symbol, const ENUM_ORDER_TYPE order_type, const double volume,
                     const double limit_price, const double price, const double sl, const double tp,
                     ENUM_ORDER_TYPE_TIME type_time = ORDER_TIME_GTC, const datetime expiration = 0,
                     const string comment = "" );
   bool   PositionClose( int ticket );
   bool   PositionModify( const ulong ticket, const double sl, const double tp );
   bool   PositionOpen( const string symbol, const ENUM_ORDER_TYPE order_type, const double volume,
                        const double price, const double sl, const double tp, const string comment );

   double ResultPrice() { return ( mResult.price ); }
};

CTrade::CTrade() { m_magic = 0; }

CTrade::~CTrade() {}

void CTrade::ClearStructures() { ZeroMemory( mResult ); }

bool CTrade::Buy( const double volume, const string symbol = NULL, double price = 0.0,
                  const double sl = 0.0, const double tp = 0.0, const string comment = "" ) {
   if ( price == 0.0 ) price = BuyPrice( symbol );
   return ( PositionOpen( symbol, ORDER_TYPE_BUY, volume, price, sl, tp, comment ) );
}

bool CTrade::Sell( const double volume, const string symbol = NULL, double price = 0.0,
                   const double sl = 0.0, const double tp = 0.0, const string comment = "" ) {
   if ( price == 0.0 ) price = SellPrice( symbol );
   return ( PositionOpen( symbol, ORDER_TYPE_SELL, volume, price, sl, tp, comment ) );
}

bool CTrade::OrderOpen( const string symbol, const ENUM_ORDER_TYPE order_type, const double volume,
                        const double limit_price, const double price, const double sl,
                        const double tp, ENUM_ORDER_TYPE_TIME type_time = ORDER_TIME_GTC,
                        const datetime expiration = 0, const string comment = "" ) {

   int ticket =
      OrderSend( symbol, order_type, volume, price, 0, sl, tp, comment, m_magic, expiration );
   return ( ticket > 0 );
}

bool CTrade::PositionClose( int ticket ) {

   if ( !OrderSelect( ticket, SELECT_BY_TICKET ) ) return ( false );
   if ( OrderType() == ORDER_TYPE_BUY || OrderType() == ORDER_TYPE_SELL ) {
      return ( OrderClose( ticket, OrderLots(), OrderClosePrice(), 0 ) );
   }
   return ( OrderDelete( ticket ) );
}

bool CTrade::PositionModify( const ulong ticket, const double sl, const double tp ) {

   ulong currentTicket = OrderTicket();
   if ( currentTicket != ticket ) {
      if ( !OrderSelect( ( int )ticket, SELECT_BY_TICKET ) ) return ( false );
   }
   bool result = OrderModify( ( int )ticket, OrderOpenPrice(), sl, tp, OrderExpiration() );
   if ( currentTicket != ticket ) {
      if ( !OrderSelect( ( int )currentTicket, SELECT_BY_TICKET ) ) {
      }
   }
   return ( result );
}

bool CTrade::PositionOpen( const string symbol, const ENUM_ORDER_TYPE order_type,
                           const double volume, const double price, const double sl,
                           const double tp, const string comment ) {

   //--- clean
   ClearStructures();

   //--- check
   if ( order_type != ORDER_TYPE_BUY && order_type != ORDER_TYPE_SELL ) {
      mResult.retcode = TRADE_RETCODE_INVALID;
      mResult.comment = "Invalid order type";
      return ( false );
   }

   int ticket   = OrderSend( symbol, order_type, volume, price, 0, sl, tp, comment, m_magic );

   mResult.deal = ticket;
   if ( OrderSelect( ticket, SELECT_BY_TICKET ) ) {
      mResult.price = OrderOpenPrice();
   }

   return ( ticket > 0 );
}

/*
 *	CTradeCustom
 *
 *	Features not in the standard CTrade class
 *
 */

class CTradeCustom : public CTrade {

public:
   CTradeCustom() : CTrade() {}
   ~CTradeCustom() {}

   bool OrderDelete( const string symbol, ENUM_ORDER_TYPE orderType );

   bool PositionCloseByType( const string symbol, ENUM_POSITION_TYPE positionType,
                             const int deviation = ULONG_MAX );
   void PositionCountByType( const string symbol, int &count[] );
};

bool CTradeCustom::OrderDelete( const string symbol, ENUM_ORDER_TYPE orderType ) {

   bool result = true;
   for ( int i = OrdersTotal() - 1; i >= 0; i-- ) {
      if ( OrderSelect( i, SELECT_BY_POS, MODE_TRADES ) ) {
         if ( OrderSymbol() == symbol && OrderType() == orderType &&
              OrderMagicNumber() == m_magic ) {
            result &= OrderDelete( OrderTicket() );
         }
      }
   }
   return ( result );
}

bool CTradeCustom::PositionCloseByType( const string symbol, ENUM_POSITION_TYPE positionType,
                                        const int deviation = ULONG_MAX ) {

   int  slippage = ( deviation == ULONG_MAX ) ? 0 : deviation;

   bool result   = true;
   int  cnt      = OrdersTotal();
   for ( int i = cnt - 1; i >= 0; i-- ) {
      if ( OrderSelect( i, SELECT_BY_POS, MODE_TRADES ) ) {
         if ( OrderSymbol() == symbol && OrderMagicNumber() == m_magic &&
              OrderType() == positionType ) {
            result &= OrderClose( OrderTicket(), OrderLots(), OrderClosePrice(), slippage );
         }
      }
   }

   return ( result );
}

void CTradeCustom::PositionCountByType( const string symbol, int &count[] ) {

   ArrayResize( count, 6 );
   ArrayInitialize( count, 0 );
   int cnt = OrdersTotal();
   for ( int i = cnt - 1; i >= 0; i-- ) {
      if ( OrderSelect( i, SELECT_BY_POS, MODE_TRADES ) ) {
         if ( OrderSymbol() == symbol && OrderMagicNumber() == m_magic ) {
            count[( int )OrderType()]++;
         }
      }
   }

   return;
}
