local quantCore = QuantCORE();

local orderManager = quantCore:OrderManager();
local limitManager = quantCore:LimitManager();

local productPath = "SIM.O.XJO.MAY2013.4650.C.0";
local price = 200;
local volume = 2.0;

function OnStart()
	limitManager:AddProduct(productPath);
	
	-- Only check filled option product order
	limitManager:AbsFilledDelta(5, 1000);
	
	-- Send three orders (Adjust the price and volume)
	for i=1, 6 do
		local order = orderManager:BuildOrder( productPath, price, volume, QS_BUY, "", "", QS_GFD );
		orderID = orderManager:SendOrderObject( order, false );
	end
	
	-- Trade the order with another user in MV
	-- If the traded delta exceeds our limit, QuantENGINE should log fatal and pull all orders.
end

function OnStop()

end