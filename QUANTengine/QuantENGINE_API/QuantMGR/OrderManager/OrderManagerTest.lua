
local quantCore = QuantCORE();
local limitManager = quantCore:LimitManager();
local orderManager = quantCore:OrderManager();
local productManager = quantCore:ProductManager();
local priceManager = quantCore:PriceManager();

local productPath = "SIM.O.NK.SEP2012.7875.C.0";

--local timer_Id=100;
--local timer_Interval=15000;



local volume = 10;

local priceBuy = 160;
local priceBuyAmend = 155
local volumeAmend = 15
local priceSell = 175;

local User = "Marcus_Chang";

function OnStart()
	
	limitManager:AddProduct(productPath);

	priceManager:SubscribePrice(productPath, false, "OrderManagerTest.lua");

	orderManager:SubscribeOrder(productPath,User, false, false, "OrderManagerTest.lua");	

	local orderBuy = orderManager:BuildOrder(productPath, priceBuy, volume, QS_BUY,"","",QS_GFD);
	local OrderIDbuy = orderManager:SendOrderObject(orderBuy,false);
	
	local foundBuy = orderManager:FindOrder(OrderIDbuy, productPath)
	
	print("------------->foundBuy's strike ="..tostring(foundBuy:Strike()))
	
	local SendSELL = orderManager:SendOrder(productPath, 190, 30, QS_SELL, nil, nil, QS_GFD, false)
	
	Sleep(3000)
	orderManager:PullOrder(SendSELL)
	Sleep(1000)
	
	local orderSell = orderManager:BuildOrder(productPath, priceSell, volume, QS_SELL,"","",QS_GFD);
	local OrderIDsell = orderManager:SendOrderObject(orderSell,false);
	
	local foundSell = orderManager:FindOrder(OrderIDsell, productPath)
	
	print("------------->foundSell's ID ="..tostring(foundSell:quantCoreOrderID()))
	
	Sleep(1500)
	orderManager:PullOrder(OrderIDbuy)
	Sleep(2500)
	local orderBuy1 = orderManager:BuildOrder(productPath, priceBuyAmend, volumeAmend, QS_BUY,"","",QS_GFD);
	local OrderIDbuy1 = orderManager:SendOrderObject(orderBuy1,false);
	orderBuy1:Price(155)
	orderBuy1:Volume(20)
	
	if orderManager:AmendOrder(orderBuy1) == true then 
		print("------------------Amend OrderBuy successful-------------------")
	end
--[[	
	local snapTable = orderManager:SnapshotOrder(productPath, User, true, false)
	
	if not snapTable == nil then
		for k, v in pairs(snapTable) do
			print("key ="..tostring(k))
			print("value ="..tostring(v)) 
		end
	else 
		print("snapTable is nil -----------------!!!!")
	
	end
]]--	
	Sleep(3000)
	orderManager:PullAllOrders()
	Sleep(500)
	
	local quoteBuy = orderManager:BuildOrder(productPath, priceBuy, volume, QS_BUY, "", "", QS_GFD);
	local quoteSell = orderManager:BuildOrder(productPath, priceSell, volume, QS_SELL,"","",QS_GFD);
	
	orderManager:SendQuotes(quoteBuy, quoteSell, false)
	
	
	quoteBuy:Price(160)
	quoteBuy:Volume(100)
	
	quoteSell:Price(180)
	quoteSell:Volume(100)
	
	Sleep(3000)
	orderManager:AmendQuotes(quoteBuy, quoteSell)

--	Sleep(3000)
--	orderManager:PullAllOrders()
--	Sleep(500)
	
	


--	Sleep(1500)
	
--	
	
	
			
	--Timer(timer_Id,timer_Interval,"");
end


function OnOrder(order, isRemoved)
	
	
	local snapTable = orderManager:SnapshotOrder(productPath, User, true, false)
	
	if snapTable ~= nil then
		for k, v in pairs(snapTable) do
			print("key ="..tostring(k))
			print("value ="..tostring(v)) 
		end
	else 
		print("snapTable is nil -----------------!!!!")
	
	end
	
	
	print("AccountCode ="..tostring(order:AccountCode()))
	print("BuySell ="..tostring(order:BuySell()))
	print("CounterParty ="..tostring(order:CounterParty()))
	print("Exchange ="..tostring(order:Exchange()))
	print("ExchangeAccount ="..tostring(order:ExchangeAccount()))
	print("ExchangeOrderID ="..tostring(order:ExchangeOrderID()))
	print("ExchangeUser ="..tostring(order:ExchangeUser()))
--	print("ExcutedVolume ="..tostring(order:ExcutedVolume()))
	print("MassOrderID ="..tostring(order:MassOrderID()))
	print("MinimumVolume ="..tostring(order:MinimumVolume()))
	print("Note1 ="..tostring(order:Note1()))
	print("Note2 ="..tostring(order:Note2()))
	print("OpenClose ="..tostring(order:OpenClose()))
	print("OrderExpiry ="..tostring(order:OrderExpiry()))
	print("OrderRestriction ="..tostring(order:OrderRestriction()))
	print("OrderServerTimestamp ="..tostring(order:OrderServerTimestamp()))
	print("PostingCode ="..tostring(order:PostingCode()))
	print("Price ="..tostring(order:Price()))
	print("Product ="..tostring(order:Product()))
	print("ProductPath ="..tostring(order:ProductPath()))
	print("ProductType ="..tostring(order:ProductType()))
	print("Simulation ="..tostring(order:Simulation()))
	print("QuoteID ="..tostring(order:QuoteID()))
	print("ReservedExchangeRef ="..tostring(order:ReservedExchangeRef()))
	print("ResidualVolume ="..tostring(order:ResidualVolume()))
	print("SystemText ="..tostring(order:SystemText()))
	print("TriggerPrice ="..tostring(order:TriggerPrice()))
	print("UserFixedDecimal1 ="..tostring(order:UserFixedDecimal1()))
	print("UserFixedDecimal2 ="..tostring(order:UserFixedDecimal2()))
	print("UserGroup ="..tostring(order:UserGroup()))
--	print("UserInt1 ="..tosting(order:UserInt1()))
--	print("UserInt2 ="..tostirng(order:UserInt2()))
	print("UserName ="..tostring(order:UserName()))
	print("Volume ="..tostring(order:Volume()))
	print("PricingSpec ="..tostring(order:PricingSpec()))
	print("OrderTheo ="..tostring(order:OrderTheo()))
	print("OrderDelta ="..tostring(order:OrderDelta()))
	print("OrderGamma ="..tostring(order:OrderGamma()))
	print("OrderVega ="..tostring(order:OrderVega()))
	print("OrederTheta ="..tostring(order:OrderTheta()))
	print("OrderRho ="..tostring(order:OrderRho()))
--[[
string rsOrder:TOM_Note()
number rsOrder:TOM_Type()
number rsOrder:TOM_Price()
number rsOrder:AC_Offset()
number rsOrder:AC_Price()
number rsOrder:AS_Price()
	print("Status ="..tostring(order:Status()))

number rsOrder:SequenceNr()
string rsOrder:ATT_Note()
number rsOrder:ATT_Type()
]]--
	print("quantCoreOrderID ="..tostring(order:quantCoreOrderID()))
	print("Date ="..tostring(order:Date()))
	print("Series ="..tostring(order:Series()))
	print("Day ="..tostring(order:Day()))
	print("Month ="..tostring(order:Month()))
	print("Year ="..tostring(order:Year()))
--rsOptionTypeEnum CallPut()
	print("Strike ="..tostring(order:Strike()))
--number VersionNr()
	order:BuySell(9999999999)
	print("BuySell2 ="..tostring(order:BuySell()))
--rsOrder:CounterParty( string aCounterParty )
	order:Note1("fdasfafda")
	print("Note1* ="..tostring(order:Note1()))
	order:Note2("kjklj;l")
	print("Note2* ="..tostring(order:Note2()))
	order:Price(-9999999999)
	print("Price* ="..tostring(order:Price()))
	order:Volume(20)
	print("Volume* ="..tostring(order:Volume()))
end

function OnOrderNotify(productPath, orderID, removed)
	print("OnOrderNotify is ok")
end


function OnPrice(price)
	print("rsPrice:ProductPath ="..tostring(price:ProductPath()))
end



function OnStop()	
	print("Order Placed finished!");
	priceManager:UnsubscribePrice(productPath, false, "OrderManagerTest.lua");
	orderManager:UnsubscribeOrder(productPath,user, false, false, "OrderManagerTest.lua")
end