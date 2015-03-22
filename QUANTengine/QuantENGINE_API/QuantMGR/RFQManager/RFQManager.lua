local quantCore = QuantCORE();
local rfqManager = quantCore:RFQManager();
local productPath = "SIM.O.XJO.DEC2012.3900.C.0";



function OnStart()
	
	rfqManager:SubscribeRFQ(productPath, false, "RFQManager.lua")
	
	Sleep(10000) --here we need this sleep as the RFQ machine using the asynchronous communication to update the status. 
	
	local rfqSnapTbl = rfqManager:SnapshotRFQs(productPath)	
	
	if rfqSnapTbl ~= nil then
		for k,v in pairs(rfqSnapTbl) do
			print("the rfqSnapTbl's key ="..tostring(k))
			print("the rfqSnapTbl's value ="..tostring(v))
		end
	else
		print("----------the rfqSnapTbl is nil---------")
	end
	
	
end


function OnRFQUpdate(request)
	print("The Product() is "..tostring(request:Product()))
	print("The ProductPath() is "..tostring(request:ProductPath()))
	print("The BuyQuantity() is "..tostring(request:BuyQuantity()))
	print("The SellQuantity() is "..tostring(request:SellQuantity()))
	print("The TimeStamp() is "..tostring(request:TimeStamp()))
	print("The Exchange() is "..tostring(request:Exchange()))	 
	print("The ExchangeRef() is "..tostring(request:ExchangeRef()))
	print("The RequestType() is "..tostring(request:RequestType()))
	print("The BuyPrice() is "..tostring(request:BuyPrice()))
	print("The SellPrice() is "..tostring(request:SellPrice()))
	
	---------------------------------------------
	
	request:BuyQuantity(17)
	request:SellQuantity(17)
	request:BuyPrice(2000)
	request:SellPrice(2000)
	request:Exchange("ASX")
	request:ExchangeRef("HKFE")
	request:RequestType(QS_EXCHANGE_REQUEST_TYPE_CROSS)
	request:TimeStamp("15:15:15")
	
	----------------------------------------------
	
	print("The TimeStamp() updated value is "..tostring(request:TimeStamp()))
	print("The RequestType() updated value is "..tostring(request:RequestType()))
	print("The Exchange() updated value is "..tostring(request:Exchange()))	 
	print("The ExchangeRef() updated value is "..tostring(request:ExchangeRef()))
	print("The BuyQuantity() updated value is "..tostring(request:BuyQuantity()))
	print("The SellQuantity() updated value is "..tostring(request:SellQuantity()))
	print("The BuyPrice() updated value is "..tostring(request:BuyPrice()))
	print("The SellPrice() updated value is "..tostring(request:SellPrice()))
	
	
	
end


function OnRFQUpdateNotify(productPath)
	print("------------>OnRFQ Notify begins<-----------")
end


function OnStop()
	rfqManager:UnsubscribeRFQ(productPath, false, "RFQManager.lua")		
	
	
end