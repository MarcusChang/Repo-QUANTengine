local quantCore = QuantCORE();

local orderManager = quantCore:OrderManager();
local limitManager = quantCore:LimitManager();

local productPath = "SIM.F.XJO.SEP2013";
local price = 200;
local volume = 2.0;

function OnStart()
	limitManager:AddProduct(productPath);
	
	-- Only check filled delta one product order
	--limitManager:Notional(1000000);
	--limitManager:Notional(1000000, 100000);
	
	--limitManager:AbsNotional(1000000);
	--limitManager:AbsNotional(1000000, 100000);
	
	-- Send three orders (Adjust the price and volume)
	for i=1, 6 do
		local order0 = orderManager:BuildOrder( productPath, price, volume, QS_BUY, "", "", QS_GFD );
		orderID = orderManager:SendOrderObject( order0, false );
	end
--[[	
	for i=1, 3 do
		local order1 = orderManager:BuildOrder( productPath, price, volume, QS_SELL, "", "", QS_GFD );
		orderID = orderManager:SendOrderObject( order, false );
	end
--]]	
	-- Trade the order with another user in MV
	-- If the traded notional value exceeds our limit, QuantENGINE should log fatal and pull all orders.
end

function OnStop()

end