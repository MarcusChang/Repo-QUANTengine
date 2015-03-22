local quantCore = QuantCORE();

local orderManager = quantCore:OrderManager();
local limitManager = quantCore:LimitManager();

local productPath = "SIM.O.XJO.SEP2013.2300.C.0";

local price = 200;
local volume = 2.0;

function OnStart()
	limitManager:AddProduct(productPath);

	-- Allow only one filled order within 1000s
	limitManager:FilledOrders(7, 60000);
	
	-- Send three orders
	for i=1, 10 do
		local order = orderManager:BuildOrder( productPath, price, volume, QS_BUY, "", "", QS_GFD );
		orderID = orderManager:SendOrderObject( order, false );
	end
	
	-- Trade the order with another user in MV, QuantENGINE should log fatal and pull all orders.
end

function OnStop()

end