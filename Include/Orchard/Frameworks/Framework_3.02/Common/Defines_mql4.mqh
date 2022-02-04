/*
 	Defines_mql4
 	Framework version 3.00
 	
   Copyright 2013-2022, Orchard Forex
   https://www.orchardforex.com
 
*/

enum ENUM_POSITION_TYPE {
	POSITION_TYPE_BUY,
	POSITION_TYPE_SELL
};

//	Some return code definitions
enum ENUM_TRADE_RETCODES {
	TRADE_RETCODE_INVALID		=	10013,	//	Invalid request
};

struct MqlTradeRequest {
	int    								action;           // Trade operation type (as int here) 
	ulong                         magic;            // Expert Advisor ID (magic number) 
	ulong                         order;            // Order ticket 
	string                        symbol;           // Trade symbol 
	double                        volume;           // Requested volume for a deal in lots 
	double                        price;            // Price 
	double                        stoplimit;        // StopLimit level of the order 
	double                        sl;               // Stop Loss level of the order 
	double                        tp;               // Take Profit level of the order 
	ulong                         deviation;        // Maximal possible deviation from the requested price 
	ENUM_ORDER_TYPE               type;             // Order type 
	int       							type_filling;     // Order execution type (int here) 
	int          						type_time;        // Order expiration type (int here) 
	datetime                      expiration;       // Order expiration time (for the orders of ORDER_TIME_SPECIFIED type) 
	string                        comment;          // Order comment 
	ulong                         position;         // Position ticket 
	ulong                         position_by;      // The ticket of an opposite position 
};

struct MqlTradeResult { 
   uint     retcode;          // Operation return code 
   ulong    deal;             // Deal ticket, if it is performed 
   ulong    order;            // Order ticket, if it is placed 
   double   volume;           // Deal volume, confirmed by broker 
   double   price;            // Deal price, confirmed by broker 
   double   bid;              // Current Bid price 
   double   ask;              // Current Ask price 
   string   comment;          // Broker comment to operation (by default it is filled by description of trade server return code) 
   uint     request_id;       // Request ID set by the terminal during the dispatch  
   uint     retcode_external; // Return code of an external trading system 
};


