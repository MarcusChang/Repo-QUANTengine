local quantCore = QuantCORE();

local orderManager = quantCore:OrderManager();
local limitManager = quantCore:LimitManager();

local productPath = "SIM.F.XJO.SEP2013";
local volume = 2.0;

function OnStart()
	limitManager:AddProduct(productPath);
	
	-- Only check delta one product order
	limitManager:BidAskRatio(0.9);
--	limitManager:TicksThroughBBO(5);
--	limitManager:TicksDistance(15, 600000);
	
	local order0 = orderManager:BuildOrder( productPath, 194, volume, QS_BUY, "", "", QS_GFD );
	orderID = orderManager:SendOrderObject( order0, false );
	
	Sleep(1)
	
	local order1 = orderManager:BuildOrder( productPath, 193, volume, QS_BUY, "", "", QS_GFD );
	orderID = orderManager:SendOrderObject( order1, false );
	
	Sleep(5)
	
	local order2 = orderManager:BuildOrder( productPath, 310, volume, QS_SELL, "", "", QS_GFD );
	orderID = orderManager:SendOrderObject( order2, false );
	
	Sleep(5)
	
	local order3 = orderManager:BuildOrder( productPath, 200, volume, QS_SELL, "", "", QS_GFD );
	orderID = orderManager:SendOrderObject( order3, false );
end

function OnStop()

end