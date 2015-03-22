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
local productPath = "SIM.O.XJO.SEP2013.2300.C.0"
--local productPath = "SIM.O.XJO.>"
--local productPath = "SIM.O.XJO.STRATEGIES.TIGHT.TMC.BUY.1-0.[SIM.O.XJO.JUN2013.4775.P.0].SELL.1-0.[SIM.O.XJO.JUN2013.5000.C.0]"



local volume = 10;
local priceBuy = 986;
local priceBuyAmend = 980
local volumeAmend = 15
local priceSell = 990;
local Account = "xuliang1";
local newAccount = "MAC";
local User = "";

local startday = Date:FromString("20130611")
local endday = Date:FromString("20130628")




function OnStart()

	
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
	Sleep(5000)
	
	local FindAmendTrade = tradeManager:FindTrade(AmendBuy, Account)
	if FindAmendTrade ~= nil then 
		print("FindAmendTrade is not nil")
	end
	--FindAmendTrade:PriceTraded(950)
		
	
		
	local Amendif = tradeManager:AmendTrade(FindAmendTrade, FindAmendTrade)
	
	if Amendif == true then 
		print("Amend Trade success")
	else 
		print("Amend trade failed")
	end
	
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
	
	print("OnTrade count = "..count)
	count = count + 1
	
	if fromSnapshot == true then
		print("--------------fromSnapshot is true -----------------")
	else
		print("--------------fromSnapshot is false ----------------")
	end
	
end


function OnTrade(trade)	
	
	print("trade:Action() = "..TradeActionToString(trade:Action()))
	print("trade:QuantCOREOrderID() = "..tostring(trade:QuantCOREOrderID()))
	print("trade:VolumeTraded() = "..tostring(trade:VolumeTraded()))
	print("trade:Exchange() = "..tostring(trade:Exchange()))
	print("trade:PriceTraded() = "..tostring(trade:PriceTraded()))
	print("trade:UserName() = "..tostring(trade:UserName()))
	print("trade:AccoungID() = "..tostring(trade:AccountID()))
	print("trade:BuySell() = "..BuySellToString(trade:BuySell()))
	print("trade:TradeTimestamp() = "..tostring(trade:TradeTimestamp()))
	print("trade:ResidualVolume() = "..tostring(trade:ResidualVolume()))
	print("trade:Product() = "..tostring(trade:Product()))
	print("trade:Version() = "..tostring(trade:Version()))
	print("trade:UserFixedDecimal1() = "..tostring(trade:UserFixedDecimal1()))
	print("trade:UserFixedDecimal2() = "..tostring(trade:UserFixedDecimal2()))
	print("trade:UserInt1() = "..tostring(trade:UserInt1()))
	print("trade:UserInt2() = "..tostring(trade:UserInt2()))
	print("trade:Counterparty() = "..tostring(trade:Counterparty()))
	print("trade:Note1() = "..tostring(trade:Note1()))
	print("trade:Note2() = "..tostring(trade:Note2()))
	print("trade:Broker() = "..tostring(trade:Broker()))
	print("trade:SettlementDate() = "..tostring(trade:SettlementDate()))
	print("trade:TradeValue() = "..tostring(trade:TradeValue()))
	print("trade:TradeStatus() = "..tostring(trade:TradeStatus()))
	print("trade:TransactionID() = "..tostring(trade:TransactionID()))
	print("trade:TradeType() = "..TradeTypeToString(trade:TradeType()))
	print("trade:ExchangeOrderID() = "..tostring(trade:ExchangeOrderID()))
	print("trade:ExchangeTradeID() = "..tostring(trade:ExchangeTradeID()))
	print("trade:CallPut() = "..CallPutToString(trade:CallPut()))
	print("trade:Date() = "..tostring(trade:Date()))
	print("trade:Year() = "..tostring(trade:Year()))
	print("trade:Month() = "..tostring(trade:Month()))
	print("trade:Day() = "..tostring(trade:Day()))
	print("trade:OptionVersion() = "..tostring(trade:OptionVersion()))
	print("trade:PriceCurrency() = "..tostring(trade:PriceCurrency()))
	print("trade:Product() = "..tostring(trade:Product()))
	print("trade:ProductName() = "..tostring(trade:ProductName()))
	print("trade:ProductPath() = "..tostring(trade:ProductPath()))
	print("trade:ProductType() = "..ProductTypeToString(trade:ProductType()))
	print("trade:Series() = "..tostring(trade:Series()))
	print("trade:Sim() = "..ProductSimulationToString(trade:Sim()))
	print("trade:Strike() = "..tostring(trade:Strike()))
	print("trade:Time() = "..tostring(trade:Time()))
	print("trade:TradeTimestamp() = "..tostring(trade:TradeTimestamp()))
	print("trade:ValueCurrency() = "..tostring(trade:ValueCurrency()))
	print("trade:PriceCurrency() = "..tostring(trade:PriceCurrency()))
	print("trade:PriceTraded() = "..tostring(trade:PriceTraded()))
	print("trade:BuySell() = "..tostring(trade:BuySell()))
	print("trade:Note1() = "..tostring(trade:Note1()))
	print("trade:Counterparty() = "..tostring(trade:Counterparty()))
	print("trade:ResidualVolume() = "..tostring(trade:ResidualVolume()))
	
	

end



function OnTradeNotify(productPath, tradeID)
	print("OnTradeNotify is ok")
end

--[[
function OnPrice(price)
	print("Price:productPath ="..tostring(price:ProductPath()))
	
end


function OnProductNotify(productPath)
	print("OnProductNotify begin~")
end
--]]


function OnStop()
		
	print("Order Placed finished!");
	productManager:UnsubscribeProduct(productPath, false, "TestTradeManager.lua")
	priceManager:UnsubscribePrice(productPath, false, "TestTradeManager.lua");
	tradeManager:UnsubscribeTrade(productPath, Account, startday, endday, false, "TestTradeManager.lua")
end