/*
   Trade_mql5.mqh
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

#include <Trade/Trade.mqh>

class CTradeCustom : public CTrade {

private:
protected: // member variables
public:    // constructors
public:
   bool OrderDelete( const string symbol, ENUM_ORDER_TYPE orderType );
   bool PositionCloseByType( const string symbol, ENUM_POSITION_TYPE positionType,
                             const ulong deviation = ULONG_MAX );
   void PositionCountByType( const string symbol, int &count[] );
};

bool CTradeCustom::OrderDelete( const string symbol, ENUM_ORDER_TYPE orderType ) {

   bool result = true;
   for ( int i = OrdersTotal() - 1; i >= 0; i-- ) {
      ulong ticket = OrderGetTicket( i );
      if ( OrderSelect( ticket ) ) {
         if ( OrderGetString( ORDER_SYMBOL ) == symbol &&
              OrderGetInteger( ORDER_TYPE ) == orderType &&
              OrderGetInteger( ORDER_MAGIC ) == m_magic ) {
            result &= CTrade::OrderDelete( ticket );
         }
      }
   }
   return ( result );
}

bool CTradeCustom::PositionCloseByType( const string symbol, ENUM_POSITION_TYPE positionType,
                                        const ulong deviation = ULONG_MAX ) {

   bool result = true;
   int  cnt    = PositionsTotal();
   for ( int i = cnt - 1; i >= 0; i-- ) {
      ulong ticket = PositionGetTicket( i );
      if ( PositionSelectByTicket( ticket ) ) {
         if ( PositionGetString( POSITION_SYMBOL ) == symbol &&
              PositionGetInteger( POSITION_TYPE ) == positionType &&
              PositionGetInteger( POSITION_MAGIC ) == m_magic ) {
            result &= PositionClose( ticket, deviation );
         }
      }
      else {
         m_result.retcode = TRADE_RETCODE_REJECT;
         result           = false;
      }
   }

   return ( result );
}

void CTradeCustom::PositionCountByType( const string symbol, int &count[] ) {

   ArrayResize( count, 6 );
   ArrayInitialize( count, 0 );

   int cnt = PositionsTotal();
   for ( int i = cnt - 1; i >= 0; i-- ) {
      ulong ticket = PositionGetTicket( i );
      if ( PositionSelectByTicket( ticket ) ) {
         if ( PositionGetString( POSITION_SYMBOL ) == symbol &&
              PositionGetInteger( POSITION_MAGIC ) == m_magic ) {
            count[( int )PositionGetInteger( POSITION_TYPE )]++;
         }
      }
   }

   return;
}
