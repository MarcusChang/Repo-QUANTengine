local QuantCORE = QuantCORE();
local PriceManager = QuantCORE:PriceManager();
local OrderManager = QuantCORE:OrderManager();
local limitManager = QuantCORE:LimitManager();
local productPath1 = "SIM.F.APPLES.DEC2011";

local user="Marcus_Chang";

local timer_Id=88;
local timer_Interval=5000;


function OnStart()
limitManager:AddProduct(productPath);
PriceManager:SubscribePrice(productPath,false,"");
OrderManager:SubscribeOrder(productPath,user,false,false,"");

local volume=100;
local Pricea=900;
local Priceb=100;



local Bid = OrderManager:BuildOrder(productPath,Pricea,volume,QS_BUY,"","",QS_GFD);
local orderID = OrderManager:SendOrderObject(Bid,false);


local Ask = OrderManager:BuildOrder(productPath,Priceb,volume,QS_SELL,"","",QS_GFD);
local orderID = OrderManager:SendOrderObject(Ask,false);

Timer(timer_Id,timer_Interval,"");
end

function OnStop()

end

function OnTimer( id )
  SendCompletionCode(QS_COMPLETION_CODE_SUCCESS, "Time Out");
end

function OnPrice()
end

function OnOrder()
end