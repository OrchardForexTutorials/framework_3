/*

   PositionInfo_mql4.mqh

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

#property copyright "Copyright 2021, Orchard Forex"
#property link "https://orchardforex.com"
#property version "1.01"
#property strict

#include "../Common/Defines.mqh"

class CPositionInfo
{

public:
   bool               SelectByIndex( int index );

   int                Magic() { return ( OrderMagicNumber() ); }
   ENUM_POSITION_TYPE PositionType() { return ( ( ENUM_POSITION_TYPE )OrderType() ); }
   double             PriceOpen() { return ( OrderOpenPrice() ); }
   double             StopLoss() { return ( OrderStopLoss() ); }
   string             Symbol() { return ( OrderSymbol() ); }
   double             TakeProfit() { return ( OrderTakeProfit() ); }
   int                Ticket() { return ( OrderTicket() ); }
};

/*
 *	CPositionInfoCustom::SelectByIndex
 *	Select an order by indexed position
 *	@param - index : index position of order to select
 *	@return - ticket number : 0 if the order is not buy/sell or is closed or not found
 */
bool CPositionInfo::SelectByIndex( int index ) {

   if ( !OrderSelect( index, SELECT_BY_POS, MODE_TRADES ) ) return ( false );
   if ( OrderType() != ORDER_TYPE_BUY && OrderType() != ORDER_TYPE_SELL ) return ( false );
   if ( OrderCloseTime() > 0 ) return ( false );
   return ( OrderTicket() > 0 );
}

class CPositionInfoCustom : public CPositionInfo
{

public:
   int Total() { return ( OrdersTotal() ); }
};