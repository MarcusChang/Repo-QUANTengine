--NOTE: run without set for Notional value and Ticks through BBO, will get 
--run without Ticks through BBO, get FAT:User limit: TICKS_CHANGED_THROUGH_BBO for current user exceeded! 	



local QuantCORE = QuantCORE();
local PriceManager = QuantCORE:PriceManager();
local OrderManager = QuantCORE:OrderManager();
local limitManager = QuantCORE:LimitManager();
local productPath = "SIM.F.APPLES.DEC2011";

local Price=
{80,
80.1,
80.2
}

local timer_Id=100;
local timer_Interval=5000;



function OnStart()
limitManager:AddProduct(productPath);
PriceManager:SubscribePrice(productPath, false, "");
OrderManager:SubscribeOrder(productPath,user, false, false, "");

local i = 1;
local volume = 10;
local User = "R_LXIE1";


while i<= #Price do
local order = OrderManager:BuildOrder(productPath,Price[i],volume,QS_BUY,"","",QS_GFD);
local orderID = OrderManager:SendOrderObject(order,false);

--[[local order = OrderManager:BuildOrder(productPath,Price[i],volume,QS_SELL,"","",QS_GFD);
local orderID = OrderManager:SendOrderObject(order,false);--]]


i=i+1

Timer(timer_Id,timer_Interval,"");
end

function OnStop()

end

function OnTimer( id )
  SendCompletionCode(QS_COMPLETION_CODE_SUCCESS, "Time Out");
end
end