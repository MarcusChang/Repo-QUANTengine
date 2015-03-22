
local quantCore = QuantCORE();
local limitManager = quantCore:LimitManager();
local tradeManager = quantCore:TradeManager();
local productManager = quantCore:ProductManager();
local priceManager = quantCore:PriceManager();

--local productPath = "SIM.O.XJO.STRATEGIES.TIGHT.TMC.BUY.1-0.[SIM.O.XJO.DEC2012.4150.C.0].SELL.1-0.[SIM.O.XJO.DEC2012.4750.C.0].BUY.1-0.[SIM.O.XJO.DEC2012.4800.C.0]";
--local productPath2 = "SIM.F.NK225.DEC2013"
--local productPath2 = "SIM.F.NK225.SEP2013"
--local productPath3 = "SIM.O.NK225.DEC2012.7500.C.0"

--local timer_Id=100;
--local timer_Interval=15000;

--local productPath = "SIM.F.XJO.MAY2013"
--local productPath = "SIM.F.XJO.>"
local productPath = "SIM.O.XJO.MAY2013.4650.C.0"
--local productPath = "SIM.O.XJO.>"
--local productPath = "SIM.O.XJO.STRATEGIES.TIGHT.TMC.BUY.1-0.[SIM.O.XJO.MAY2013.4375.C.0].SELL.1-0.[SIM.O.XJO.MAY2013.4475.C.0].BUY.1-0.[SIM.O.XJO.MAY2013.4525.C.0]"



local volume = 10;
local priceBuy = 986;
local priceBuyAmend = 980
local volumeAmend = 15
local priceSell = 990;
local Account = "xuliang1";
local newAccount = "MAC"
local User = "";






function OnStart()

	local startday = rsDate:FromString("20130419")
	local endday = rsDate:FromString("20130419")
	
	productManager:SubscribeProduct(productPath, false, "TestTradeManager.lua")
	
	limitManager:AddProduct(productPath);

	priceManager:SubscribePrice(productPath, false, "TestTradeManager.lua");
	
	tradeManager:SubscribeTrade(productPath, Account, startday, endday, false, "TestTradeManager.lua");
	
	
	local tradeBuy = tradeManager:BuildTrade(productPath, QS_BUY, volume, priceBuy, Account);
	
--[[	local moveAcc = tradeManager:MoveAccount(tradeBuy, newAccount)
	if moveAcc == true then
		print("the account moves successfully")
	else
		print("the account moves failed")
	end
]]--	
	local TradeBuy = tradeManager:AddTrade(tradeBuy, Account)
	print("TradeBuy ="..tostring(TradeBuy))
	
	Sleep(1000)	

	local findtradeBuy = tradeManager:FindTrade(TradeBuy, Account)
	print("FindTrade productPath = "..tostring(findtradeBuy:ProductPath()))
	
	Sleep(1000)
	
	local movAcc = tradeManager:MoveAccount(findtradeBuy, newAccount)
	print("movAccount ="..tostring(movAcc))
	
	Sleep(1000)
	
	local tradeNew = tradeManager:BuildTrade(productPath, QS_SELL, volume, priceSell, Account)
	print("tradeNew ID ="..tostring(tradeNew))
	
		
	local newTradeID = tradeManager:AddTrade(tradeNew, Account)
	print("newTradeID ="..tostring(newTradeID))

	Sleep(1000)
	
	local DeleteTradeOrder = tradeManager:DeleteTrade(newTradeID, Account)
	
	Sleep(1000)
	
	if DeleteTradeOrder == true then
		print("DeletTradeOrder success")
	else
		print("there is no trade to be deleted")
	end
	
	Sleep(1000)
	
	local tradeBuyAmend = tradeManager:BuildTrade(productPath, QS_BUY, volume, priceBuyAmend, Account);
	local AmendBuy = tradeManager:AddTrade(tradeBuyAmend, Account)
	local FindAmendTrade = tradeManager:FindTrade(AmendBuy, Account)
	FindAmendTrade:PriceTraded(950)
		
	Sleep(1000)
		
	local Amendif = tradeManager:AmendTrade(FindAmendTrade, FindAmendTrade)
	
	if Amendif == true then 
		print("Amend Trade success")
	else 
		print("Amend trade failed")
	end
	
	
	
end


function OnTrade(trade)
--[[	
	trade:PriceTraded(120)
	local Amendif = tradeManager:AmendTrade(trade, trade)
	
	if Amendif == true then 
		print("Amend Trade success")
	else 
		print("Amend trade failed")
	end
]]--	
	local startday = rsDate:FromString("20130419")
	local endday = rsDate:FromString("20130419")

	print("rsTrade:Product ="..tostring(trade:Product()))
	print("rsTrade:TradeValue ="..tostring(trade:TradeValue()))
	print("rsTrade:productPath ="..tostring(trade:ProductPath()))
	trade:Note1("test by Marcus")
	print("rsTrade:Note1 ="..tostring(trade:Note1()))

	
	
	local snapTable = tradeManager:SnapshotTrade(productPath, Account, startday, endday)	
	if snapTable ~= nil then 
		
		print("snapTrade Success!!!!")

		for k, v in pairs(snapTable) do
			print("begin to print the key <=> value")
			print("Key ======"..tostring(k))
			print("Value ======"..tostring(v))
		end
	else
		print("snapTrade fails --------------!!!")
	end

end



function OnTradeNotify(productPath, tradeID)
	print("OnTradeNotify is ok")
end


function OnPrice(price)
	print("rsPrice:productPath ="..tostring(price:ProductPath()))
	
end


function OnProductNotify(productPath)
	print("OnProductNotify begin~")
end



function OnStop()
	local startday = rsDate:FromString("20130419")
	local endday = rsDate:FromString("20130419")	
	print("Order Placed finished!");
	productManager:UnsubscribeProduct(productPath, false, "TestTradeManager.lua")
	priceManager:UnsubscribePrice(productPath, false, "TestTradeManager.lua");
	tradeManager:UnsubscribeTrade(productPath, Account, startday, endday, false, "TestTradeManager.lua")
end