local QuantCORE = QuantCORE();
local PriceManager = QuantCORE:PriceManager();
local OrderManager = QuantCORE:OrderManager();
local limitManager = QuantCORE:LimitManager();
local productPath = "SIM.O.XJO.DEC2012.3700.C.0";
local productPath1 = "SIM.O.XJO.DEC2012.3750.C.0";
local productPath2 = "SIM.O.XJO.DEC2012.3600.C.0";
local productManager = QuantCORE:ProductManager();


--local timer_Id=100;
--local timer_Interval=5000;

function OnStart()
limitManager:AddProduct(productPath);
productManager:SubscribeProduct(productPath, true, "AbsoluteNetNotional.lua")
PriceManager:SubscribePrice(productPath, false, "AbsoluteNetNotional.lua");
OrderManager:SubscribeOrder(productPath,user, false, false, "AbsoluteNetNotional.lua");



limitManager:AddProduct(productPath1);
productManager:SubscribeProduct(productPath1, true, "AbsoluteNetNotional.lua")
PriceManager:SubscribePrice(productPath1, false, "AbsoluteNetNotional.lua");
OrderManager:SubscribeOrder(productPath1,user, false, false, "AbsoluteNetNotional.lua");



limitManager:AddProduct(productPath2);
productManager:SubscribeProduct(productPath2, true, "AbsoluteNetNotional.lua")
PriceManager:SubscribePrice(productPath2, false, "AbsoluteNetNotional.lua");
OrderManager:SubscribeOrder(productPath2,user, false, false, "AbsoluteNetNotional.lua");


local volume = 100;
local price = 2975
local price1 = 2956
local price2 = 3013
--local priceSell = 5600
local User = "Marcus_Chang";

--send buy order to make buy net notional increase, send sell order to make sell notional increase. Net notional should consider the sum of buy & sell.
local order = OrderManager:BuildOrder(productPath,price,volume,QS_BUY,"","",QS_GFD);
local orderID = OrderManager:SendOrderObject(order,false);

--[[
print("begin to sleep!")
Sleep(15000)
print("finished sleeping!")
]]--


local order1 = OrderManager:BuildOrder(productPath1,price1,volume,QS_BUY,"","",QS_GFD);
local orderID = OrderManager:SendOrderObject(order1,false);

--[[
print("begin to sleep!")
Sleep(15000)
print("finished sleeping!")
]]--

local order2 = OrderManager:BuildOrder(productPath2,price2,volume,QS_BUY,"","",QS_GFD);
local orderID = OrderManager:SendOrderObject(order2,false);


--local order = OrderManager:BuildOrder(productPath,priceSell,volume,QS_SELL,"","",QS_GFD);
--local orderID = OrderManager:SendOrderObject(order,false);



--Timer(timer_Id,timer_Interval,"AbsoluteNetNotional.lua");
end


function OnStop()

end

function OnTimer( id )
  SendCompletionCode(QS_COMPLETION_CODE_SUCCESS, "Time Out");
end

function OnOrderNotify(productPath)
end

function OnOrder(order)
	print("order:OrderTheo ="..tostring(order:OrderTheo()))
end

function OnPrice(price)

end

function OnPriceNotify(productPath)
 
end