local quantCore = QuantCORE();

local orderManager = quantCore:OrderManager();
local limitManager = quantCore:LimitManager();

local productPath = "SIM.O.XJO.SEP2013.2300.C.0";
--local productPath = "SIM.O.XJO.STRATEGIES.TIGHT.TMC.BUY.1-0.[SIM.O.XJO.MAY2013.4375.C.0].SELL.1-0.[SIM.O.XJO.MAY2013.4475.C.0].BUY.1-0.[SIM.O.XJO.MAY2013.4525.C.0]"
local price = 200;
local volume = 1.0;

function OnStart()
	limitManager:AddProduct(productPath);
	
	-- Customize user limit so that there should be only one order action within 1000ms
	limitManager:Orders(5, 10000);
	--limitManager:OrdersWarning(5)
	
	-- Send order frequently. Sending action should be blocked and every 1000ms only one order sent.
	for i=1, 6 do
		local order = orderManager:BuildOrder( productPath, price, volume, QS_BUY, "", "", QS_GFD );
		orderID = orderManager:SendOrderObject( order, false );
		print("Order sent, order number is: ");
		print(i);
	end
end

function OnStop()

end