
local QuantCORE = QuantCORE();
local RiskManager = QuantCORE:RiskManager();
--local timer_ID = 100;
--local timer_Interval = 30000;



function OnStart()



 RiskManager:SubscribeRisk("SIM.O.APPLES.>","Marcus_Chang","QA_QuantSIM",false,"");
 RiskManager:SubscribeRisk("SIM.F.NK.>","Marcus_Chang","QA_NK_JLI",false,"");
 RiskManager:SubscribeRisk("SIM.O.XJO.>","Marcus_Chang","QA_XJO",false,"");
 --Timer(timer_ID,timer_Interval,"");
end


function OnStop()


 RiskManager:UnSubscribeRisk("SIM.O.APPLES.>","Marcus_Chang","QA_QuantSIM",false,"");
RiskManager:UnSubscribeRisk("SIM.F.NK.>","Marcus_Chang","QA_NK_JLI",false,"");
 RiskManager:UnSubscribeRisk("SIM.O.XJO.>","Marcus_Chang","QA_XJO",false,"");
end

function OnRisk()
 print("OnRisk");
  --while 1 do
 --end
    
end

--function OnTimer( id )
	--SendCompletionCode(QS_COMPLETION_CODE_SUCCESS, "Time Out");
--end