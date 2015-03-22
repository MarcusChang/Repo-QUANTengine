
local QuantCORE = QuantCORE();
local PriceManager = QuantCORE:PriceManager();


function OnStart()

 PriceManager:SubscribePrice("SIM.F.APPLES.>",false,"");

end


function OnStop()
 PriceManager: UnsubscribePrice("SIM.F.APPLES.>",false, "");
end


function OnPrice()
 print("OnPrice");
  while 1 do
 end
    
end
