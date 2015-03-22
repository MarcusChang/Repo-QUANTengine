
local QuantCORE = QuantCORE();
local ProductManager = QuantCORE:ProductManager();
--local timer_ID = 100;
--local timer_Interval = 30000;



function OnStart()

-- ProductManager:SubscribeProduct("PROD.E.NWS",false,"");
 ProductManager:SubscribeProduct("PROD.E.AMD",false,"");
 ProductManager:SubscribeProduct("PROD.E.MSFT",false,"");
 
 ProductManager:SubscribeProduct("SIM.F.APPLES.>",false,"");
 ProductManager:SubscribeProduct("SIM.F.LEMONS.>",false,"");
 ProductManager:SubscribeProduct("SIM.F.ORANGES.>",false,"");
 
 ProductManager:SubscribeProduct("SIM.O.APPLES.SEP2011.70.C.0",false,"");
-- ProductManager:SubscribeProduct("SIM.O.LEMONS.MAR2011.70.C.0",false,"");
-- ProductManager:SubscribeProduct("SIM.O.ORANGES.>",false,"");
 --Timer(timer_ID,timer_Interval,"");
end


function OnStop()
-- ProductManager: UnsubscribeProduct("PROD.E.NWS",false,"");
 ProductManager: UnSubscribeProduct("PROD.E.AMD",false,"");
 ProductManager: UnSubscribeProduct("PROD.E.MSFT",false,"");

 ProductManager:UnSubscribeProduct("SIM.F.APPLES.>",false,"");
 ProductManager:UnSubscribeProduct("SIM.F.LEMONS.>",false,"");
 ProductManager:UnSubscribeProduct("SIM.F.ORANGES.>",false,"");
  ProductManager:UnsubscribeProduct("SIM.O.APPLES.SEP2011.70.C.0",false,"");
-- ProductManager:UnsubscribeProduct("SIM.O.LEMONS.MAR2011.70.C.0",false,"");
-- ProductManager:UnSubscribeProduct("SIM.O.ORANGES.>",false,"");
end

function OnProduct()
 print("OnProduct");
  --while 1 do
 --end
    
end

--function OnTimer( id )
	--SendCompletionCode(QS_COMPLETION_CODE_SUCCESS, "Time Out");
--end