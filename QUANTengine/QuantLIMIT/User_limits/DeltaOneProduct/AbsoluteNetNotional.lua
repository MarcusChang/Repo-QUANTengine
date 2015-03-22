local QuantCORE = QuantCORE();
local PriceManager = QuantCORE:PriceManager();
local OrderManager = QuantCORE:OrderManager();
local limitManager = QuantCORE:LimitManager();
local productPath = "SIM.F.APPLES.DEC2011";



local timer_Id=100;
local timer_Interval=5000;

function OnStart()
limitManager:AddProduct(productPath);
PriceManager:SubscribePrice(productPath, false, "");
OrderManager:SubscribeOrder(productPath,user, false, false, "");



local volume = 1;
local price = 8
local User = "Marcus_Chang";

--send buy order to make buy net notional increase, send sell order to make sell notional increase. Net notional should consider the sum of buy & sell.
local order = OrderManager:BuildOrder(productPath,price,volume,QS_BUY,"","",QS_GFD);
local orderID = OrderManager:SendOrderObject(order,false);


--local order = OrderManager:BuildOrder(productPath,price,volume,QS_SELL,"","",QS_GFD);
--local orderID = OrderManager:SendOrderObject(order,false);



Timer(timer_Id,timer_Interval,"");
end


function OnStop()

end

function OnTimer( id )
  SendCompletionCode(QS_COMPLETION_CODE_SUCCESS, "Time Out");
end

function OnOrderNotify(productPath)
end

function OnOrder(order)
end

function OnPrice(price)

end

function OnPriceNotify(productPath)
 
end