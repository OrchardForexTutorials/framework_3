/*
   Defines_mql4
   Framework version 3.00

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

enum ENUM_POSITION_TYPE
{
   POSITION_TYPE_BUY,
   POSITION_TYPE_SELL
};

//	Some return code definitions
enum ENUM_TRADE_RETCODES
{
   TRADE_RETCODE_INVALID = 10013, //	Invalid request
};

struct MqlTradeRequest
{
   int             action;       // Trade operation type (as int here)
   ulong           magic;        // Expert Advisor ID (magic number)
   ulong           order;        // Order ticket
   string          symbol;       // Trade symbol
   double          volume;       // Requested volume for a deal in lots
   double          price;        // Price
   double          stoplimit;    // StopLimit level of the order
   double          sl;           // Stop Loss level of the order
   double          tp;           // Take Profit level of the order
   ulong           deviation;    // Maximal possible deviation from the requested price
   ENUM_ORDER_TYPE type;         // Order type
   int             type_filling; // Order execution type (int here)
   int             type_time;    // Order expiration type (int here)
   datetime expiration;  // Order expiration time (for the orders of ORDER_TIME_SPECIFIED type)
   string   comment;     // Order comment
   ulong    position;    // Position ticket
   ulong    position_by; // The ticket of an opposite position
};

struct MqlTradeResult
{
   uint   retcode; // Operation return code
   ulong  deal;    // Deal ticket, if it is performed
   ulong  order;   // Order ticket, if it is placed
   double volume;  // Deal volume, confirmed by broker
   double price;   // Deal price, confirmed by broker
   double bid;     // Current Bid price
   double ask;     // Current Ask price
   string comment; // Broker comment to operation (by default it is filled by description of trade
                   // server return code)
   uint   request_id;       // Request ID set by the terminal during the dispatch
   uint   retcode_external; // Return code of an external trading system
};
