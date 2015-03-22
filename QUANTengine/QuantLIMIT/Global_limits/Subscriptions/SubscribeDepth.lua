
local QuantCORE = QuantCORE();
local PriceManager = QuantCORE:PriceManager();
local OrderManager = QuantCORE:OrderManager();
local ProductManager = QuantCORE:ProductManager();

--local limitManager = QuantCORE:LimitManager();

local price = 
{100,
 101
}

local timer_Id=100;
local timer_Interval=8000;

function OnStart()


ProductManager:SubscribeProduct("SIM.O.APPLES.SEP2012.70.C.0", false, "SubscribeDepth.lua");
ProductManager:SubscribeProduct("SIM.O.LEMONS.JAN2012.70.C.0", false, "SubscribeDepth.lua");
ProductManager:SubscribeProduct("SIM.O.XJO.SEP2012.2000.C.0", false, "SubscribeDepth.lua");
ProductManager:SubscribeProduct("SIM.O.XJO.SEP2012.2250.C.0", false, "SubscribeDepth.lua");
ProductManager:SubscribeProduct("SIM.O.XJO.SEP2012.2500.C.0", false, "SubscribeDepth.lua");
ProductManager:SubscribeProduct("SIM.O.XJO.SEP2012.2800.C.0", false, "SubscribeDepth.lua");
ProductManager:SubscribeProduct("SIM.O.XJO.SEP2012.3100.C.0", false, "SubscribeDepth.lua");
ProductManager:SubscribeProduct("SIM.O.XJO.SEP2012.3200.C.0", false, "SubscribeDepth.lua");
ProductManager:SubscribeProduct("SIM.O.XJO.SEP2012.3300.C.0", false, "SubscribeDepth.lua");
ProductManager:SubscribeProduct("SIM.O.XJO.SEP2012.3400.C.0", false, "SubscribeDepth.lua");
ProductManager:SubscribeProduct("SIM.O.XJO.SEP2012.3500.C.0", false, "SubscribeDepth.lua");


PriceManager:SubscribePrice("SIM.O.APPLES.SEP2012.75.P.0", false, "SubscribeDepth.lua");
PriceManager:SubscribePrice("SIM.O.LEMONS.JAN2012.75.C.0", false, "SubscribeDepth.lua");

OrderManager:SubscribeOrder("SIM.O.APPLES.SEP2012.80.C.0",user, false, false, "SubscribeDepth.lua");
OrderManager:SubscribeOrder("SIM.O.LEMONS.JAN2012.75.C.0",user, false, false, "SubscribeDepth.lua");

PriceManager:SubscribeDepth("SIM.O.APPLES.SEP2012.70.C.0",false,"SubscribeDepth.lua");
PriceManager:SubscribeDepth("SIM.O.LEMONS.JAN2012.70.C.0",false,"SubscribeDepth.lua");
PriceManager:SubscribeDepth("SIM.O.XJO.SEP2012.2000.C.0",false,"SubscribeDepth.lua");
PriceManager:SubscribeDepth("SIM.O.XJO.SEP2012.2250.C.0",false,"SubscribeDepth.lua");
PriceManager:SubscribeDepth("SIM.O.XJO.SEP2012.2500.C.0",false,"SubscribeDepth.lua");
PriceManager:SubscribeDepth("SIM.O.XJO.SEP2012.2800.C.0",false,"SubscribeDepth.lua");
PriceManager:SubscribeDepth("SIM.O.XJO.SEP2012.3100.C.0",false,"SubscribeDepth.lua");
PriceManager:SubscribeDepth("SIM.O.XJO.SEP2012.3200.C.0",false,"SubscribeDepth.lua");
PriceManager:SubscribeDepth("SIM.O.XJO.SEP2012.3300.C.0",false,"SubscribeDepth.lua");
PriceManager:SubscribeDepth("SIM.O.XJO.SEP2012.3400.C.0",false,"SubscribeDepth.lua");
PriceManager:SubscribeDepth("SIM.O.XJO.SEP2012.3500.C.0",false,"SubscribeDepth.lua");


Timer(timer_Id,timer_Interval,"SubscribeDepth.lua");

--end
end

function OnStop()
--ProductManager:UnsubscribeProduct("SIM.O.APPLES.SEP2012.70.C.0", false, "SubscribeDepth.lua");
--ProductManager:UnsubscribeProduct("SIM.O.LEMONS.JAN2012.70.C.0", false, "SubscribeDepth.lua");
--PriceManager:UnsubscribePrice("SIM.O.APPLES.SEP2012.75.P.0", false, "SubscribeDepth.lua");
--PriceManager:UnsubscribePrice("SIM.O.LEMONS.NOV2011.75.C.0", false, "SubscribeDepth.lua");
--OrderManager:UnsubscribeOrder("SIM.O.APPLES.OCT2011.75.C.0",user, false, false, "SubscribeDepth.lua");
--OrderManager:UnsubscribeOrder("SIM.O.LEMONS.NOV2011.75.C.0",user, false, false, "SubscribeDepth.lua");
PriceManager:UnsubscribeDepth("SIM.O.APPLES.SEP2012.70.C.0",false,"SubscribeDepth.lua");
PriceManager:UnsubscribeDepth("SIM.O.LEMONS.JAN2012.70.C.0",false,"SubscribeDepth.lua");


StopTimer(timer_Id);
end

function OnDepth(depth)
  print("depth:ProductPath() = "..tostring(depth:ProductPath()))
  print("depth:Product() = "..tostring(depth:Product()))
  print("depth:ProductName() = "..tostring(depth:ProductName()))
  print("depth:AskDepthCount() = "..tostring(depth:AskDepthCount()))
  print("depth:BidDepthCount() = "..tostring(depth:BidDepthCount()))
  print("depth:AskPrice(0) = "..tostring(depth:AskPrice(0)))
  print("depth:AskVolume(0) = "..tostring(depth:AskVolume(0)))
  print("depth:BidPrice(0) = "..tostring(depth:BidPrice(0)))
  print("depth:BidVolume(0) = "..tostring(depth:BidVolume(0))) 
  print("depth:Ask(0) = "..tostring(depth:Ask(0)))
  print("depth:Bid(0) = "..tostring(depth:Bid(0)))
  print("depth:AccumulativeBid(0) = "..tostring(depth:AccumulativeBid(0)))
  print("depth:AccumulativeAsk(0) = "..tostring(depth:AccumulativeAsk(0)))
end



function OnDepthNotify(productPath1)
  print("OnDepthNotify1");
  print("productPath = "..productPath1);
  
end

function OnDepthNotify(productPath2)
  print("OnDepthNotify2");
  print("productPath = "..productPath2);
  
end


function OnTimer( id )
  SendCompletionCode(QS_COMPLETION_CODE_SUCCESS, "Time Out");
end