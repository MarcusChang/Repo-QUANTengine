--user can user this to test subscribetheo, if user set the TheoSubscription gobal limit to 1,and subscribe 2 products, the theo subscription will be cancelled.

local QuantCORE = QuantCORE();
local TheoManager = QuantCORE:TheoManager();
local timer_ID = 100;
local timer_Interval = 60000;

function OnStart()

 TheoManager:SubscribeTheo("SIM.O.APPLES.>","QA_QuantSIM",false,"");
 TheoManager:SubscribeTheo("SIM.O.LEMONS.>","QA_LEMONS",false,"");
 Timer(timer_ID,timer_Interval,"");
end


function OnStop()
 TheoManager:UnsubscribeTheo("SIM.O.APPLES.>","QA_QuantSIM",false,"");
 TheoManager:UnsubscribeTheo("SIM.O.LEMONS.>","QA_LEMONS",false,"");
    
end

function OnTheo()
 print("OnTheo")
end

function OnTimer( id )
	SendCompletionCode(QS_COMPLETION_CODE_SUCCESS, "Time Out");
end