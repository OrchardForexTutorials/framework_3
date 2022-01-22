/*
 	ExpertBase.mqh
 	Framework version 3.00
 	
   Copyright 2013-2022, Orchard Forex
   https://www.orchardforex.com
 
*/

#include "../Framework_Version.mqh"

#include "../Common/Defines.mqh"
#include "../Common/CommonBase.mqh"

class CExpertBase : public CCommonBase {

private:

protected:

public:

	CExpertBase() {}
	~CExpertBase() {}
	
	virtual int		OnInit()							{	return(INIT_SUCCEEDED);	}
	virtual void	OnDeinit(const int reason)	{	return;	}
	virtual void	OnTick()							{	return;	}
	
};


