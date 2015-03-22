local quantCore = QuantCORE();
local productManager = quantCore:ProductManager();
local productPath = "SIM.O.XJO.>"
local Exchange = "ASX"

function OnStart()
	productManager:SubscribeProduct(productPath, false, "ProductManager.lua")
	--productManager:SubscribeProduct(productPath, true, "ProductManager.lua")
	
	Sleep(5000)
	
	local productSNtable = productManager:SnapshotProduct(productPath)
	if productSNtable ~= nil then
		for k, v in pairs(productSNtable) do
			print("the k = "..tostring(k))
			print("the v = "..tostring(v))
		end
	end

end

function OnStop()
	productManager:UnsubscribeProduct(productPath, false, "ProductManager.lua")
	--productManager:UnsubscribeProduct(productPath, true, "ProductManager.lua")
end



function OnProduct(product, fromSnapshot)

	print(">>>>>>>>>>Begin the OnProduct Callback<<<<<<<<<<<<<<")

	if fromSnapshot == true then
		print("----------fromSnapshot == true------------")
	else
		print("----------fromSnapshot == false------------")
	end

	local getExchangeTbl = product:GetExchanges()
	if getExchangeTbl ~= nil then
		for k, v in pairs(getExchangeTbl) do
			print("[getExchangeTbl] -> K = "..tostring(k))
			print("[getExchangeTbl] -> V = "..tostring(v))
		end
	else
		print("[getExchangeTbl] -> nil")
	end
	
	print("[Tradeble] -> "..tostring(product:Tradeble(Exchange)))	
	print("[MinQuoteQty] -> "..tostring(product:MinQuoteQty(Exchange)))
	print("[GetMaxQuoteBlockSize] -> "..tostring(product:GetMaxQuoteBlockSize(Exchange)))
	print("[GetAllowOneSidedQuotes] -> "..tostring(product:GetAllowOneSidedQuotes(Exchange)))
	print("[GetRequireEqualBidAskQuoteSizes] -> "..tostring(product:GetRequireEqualBidAskQuoteSizes(Exchange)))
	print("[GetProductState] -> "..tostring(product:GetProductState(Exchange)))
	print("[DefaultExchange] -> "..tostring(product:DefaultExchange()))
	print("[Active] -> "..tostring(product:Active()))
	print("[DeletionDate] -> "..tostring(product:DeletionDate()))
	print("[ProductDescription] -> "..tostring(product:ProductDescription()))
	print("[ProductName] -> "..tostring(product:ProductName()))
	print("[ProductPath] -> "..tostring(product:ProductPath()))
	print("[PointValue] -> "..tostring(product:PointValue()))
	print("[ISIN] -> "..tostring(product:ISIN()))
	print("[LastTradingDate] -> "..tostring(product:LastTradingDate()))
	print("[LastTradingTime] -> "..tostring(product:LastTradingTime()))
	print("[CashSettled] -> "..tostring(product:CashSettled()))
	print("[QuoteMethod] -> "..tostring(product:QuoteMethod()))
	print("[ExpirationSettlementDate] -> "..tostring(product:ExpirationSettlementDate()))
	--print("[GetAutoExercise] -> "..tostring(product:GetAutoExercise(Exchange)))
	print("[ExerciseType] -> "..tostring(product:ExerciseType()))
	print("[ReferenceDelta] -> "..tostring(product:ReferenceDelta()))
	print("[ReferencePrice] -> "..tostring(product:ReferencePrice()))
	print("[AsPath] -> "..tostring(product:AsPath()))
	print("[ProductType] -> "..tostring(product:ProductType()))
	print("[Simulation] -> "..tostring(product:Simulation()))
	print("[Product] -> "..tostring(product:Product()))
	print("[Series] -> "..tostring(product:Series()))
	print("[Strike] -> "..tostring(product:Strike()))
	print("[CallPut] -> "..tostring(product:CallPut()))
	print("[Version] -> "..tostring(product:Version()))
	print("[StrategyType] -> "..tostring(product:StrategyType()))
	print("[TightStrategy] -> "..tostring(product:TightStrategy()))
	print("[Tradable] -> "..tostring(product:Tradable()))
	print("[MinQuoteQty] -> "..tostring(product:MinQuoteQty()))
	print("[AllowOneSidedQuotes] -> "..tostring(product:AllowOneSidedQuotes()))
	print("[RequireEqualBidAskQuoteSizes] -> "..tostring(product:RequireEqualBidAskQuoteSizes()))
	print("[ProductState] -> "..tostring(product:ProductState()))
	print("[CreationTime] -> "..tostring(product:CreationTime()))
	print("[DynamicDepth] -> "..tostring(product:DynamicDepth()))
	print("[Currency] -> "..tostring(product:Currency()))
	print("[PointPriceIncrementSize] -> "..tostring(product:PointPriceIncrementSize()))
	print("[PointPriceIncrements] -> "..tostring(product:PointPriceIncrements()))
	print("[PriceIncrementRule] -> "..tostring(product:PriceIncrementRule()))
	print("[AutoExercise] -> "..tostring(product:AutoExercise()))

end

function OnProductNotify(productPath, fromSnapshot)
	print(">>>>>>>>>>Begin the OnProductNotify Callback<<<<<<<<<<<<<<")

	if fromSnapshot == true then
		print("----------fromSnapshot == true------------")
	else
		print("----------fromSnapshot == false------------")
	end
end
