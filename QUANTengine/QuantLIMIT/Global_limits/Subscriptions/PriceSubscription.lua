
local QuantCORE = QuantCORE();
local PriceManager = QuantCORE:PriceManager();
--local timer_ID = 100;
--local timer_Interval = 30000;



function OnStart()

 PriceManager:SubscribePrice("PROD.E.NWS",false,"");
-- PriceManager:SubscribePrice("PROD.E.AMD",false,"");
-- PriceManager:SubscribePrice("PROD.E.MSFT",false,"");
 PriceManager:SubscribePrice("SIM.F.APPLES.>",false,"");
 PriceManager:SubscribePrice("SIM.F.LEMONS.>",false,"");
 PriceManager:SubscribePrice("SIM.F.ORANGES.>",false,"");
-- PriceManager:SubscribePrice("SIM.O.APPLES.SEP2011.70.C.0",false,"");
-- PriceManager:SubscribePrice("SIM.O.LEMONS.MAR2011.70.C.0",false,"");
 PriceManager:SubscribePrice("SIM.O.ORANGES.>",false,"");
 --Timer(timer_ID,timer_Interval,"");
end


function OnStop()
 PriceManager: UnsubscribePrice("PROD.E.NWS",false,"");
-- PriceManager: UnSubscribePrice("PROD.E.AMD",false,"");
-- PriceManager: UnSubscribePrice("PROD.E.MSFT",false,"");

 PriceManager:UnSubscribePrice("SIM.F.APPLES.>",false,"");
 PriceManager:UnSubscribePrice("SIM.F.LEMONS.>",false,"");
 PriceManager:UnSubscribePrice("SIM.F.ORANGES.>",false,"");
-- PriceManager:UnsubscribePrice("SIM.O.APPLES.SEP2011.70.C.0",false,"");
--PriceManager:UnsubscribePrice("SIM.O.LEMONS.MAR2011.70.C.0",false,"");
 PriceManager:UnSubscribePrice("SIM.O.ORANGES.>",false,"");
end

function OnPrice()
 print("OnPrice");
  --while 1 do
 --end
    
end

--function OnTimer( id )
	--SendCompletionCode(QS_COMPLETION_CODE_SUCCESS, "Time Out");
--end