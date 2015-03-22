local quantCore = QuantCORE();
local priceManager = quantCore:PriceManager();
local productManager = quantCore:ProductManager();

local productPath="SIM.O.XJO.SEP2012.2000.C.0";

function OnStart()
	--productManager:SubscribeProduct( productPath, false, "");
	priceManager:SubscribePrice( productPath, false, "");
	PriceManager:SubscribeDepth(productPath, false, "")
	
	local PMstpTbl = PriceManager:SnapshotPrice(productPath, QS_PRICE_LAST_UPDATE)
		if PMstpTbl ~= nil then
			for kp1, vp1 in pairs(PMstpTbl) do
				print("[i] = "..tostring(i).." ; kp1 and vp1 in PMstpTbl ->"..tostring(kp1).."="..tostring(vp1))
			end
		end
	
	local PMstdTbl = PriceManager:SnapshotDepth(productPath)
		if PMstdTbl ~= nil then
			for kp2, vp2 in pairs(PMstdTbl) do
				print("[i] = "..tostring(i).." ; kp2 and vp2 in PMstdTbl ->"..tostring(kp2).."="..tostring(vp2))
			end
		end
	
	local PMstlTbl = PriceManager:SnapshotLeg(productPath)
		if PMstlTbl ~= nil then
			for kp3, vp3 in pairs(PMstdTbl) do
				print("[i] = "..tostring(i).." ; kp3 and vp3 in PMstlTbl ->"..tostring(kp3).."="..tostring(vp3))
			end
		else
			print("SnapshotLeg = nil")
		end
	
	--Build a price object for user price.
	local price = priceManager:BuildUserPrice(productPath);
	
	--Set user price information in the price object.
	price:SetNumberField(QS_PRC_USER_MANUAL,1);
	price:SetNumberField(QS_PRC_USER_BID_PRICE,120.50);
	price:SetNumberField(QS_PRC_USER_BID_VOLUME,100);
	price:SetNumberField(QS_PRC_USER_ASK_PRICE,120.00);
	price:SetNumberField(QS_PRC_USER_ASK_VOLUME,80);
	price:SetNumberField(QS_PRC_USER_LAST_PRICE,121.00);
	price:SetNumberField(QS_PRC_USER_LAST_VOLUME,122);
	
	price:SetStringField(QS_PRC_USER_BID_SOURCE,"$#%&*_^%&$:><?|");
	price:SetStringField(QS_PRC_USER_ASK_SOURCE,"$#%&*_^%&$:><?|");
	price:SetStringField(QS_PRC_USER_LAST_SOURCE,"$#%&*_^%&$:><?|");
	price:SetStringField(QS_PRC_COMMENT,"D1");
	
	--Send user price to Reacttor.	
	priceManager:SendUserPrice(price);
end

function OnStop()
	priceManager:UnsubscribePrice( productPath, false, "");
	--productManager:UnsubscribeProduct( productPath, false, "");
end

local count = 1
function OnPrice(price, fromSnapshot)

print(">>>>>>>>>>Begin the OnPrice Callback<<<<<<<<<<<<<<")

	if fromSnapshot == true then
		print("----------fromSnapshot == true------------")
	else
		print("----------fromSnapshot == false------------")
	end

print("OnPrice count = "..count)
count = count + 1
  print("price:GetNumberField(QS_PRC_USER_MANUAL) = "..tostring(price:GetNumberField(QS_PRC_USER_MANUAL)))
  print("price:GetNumberField(QS_PRC_USER_LAST_VOLUME) = "..tostring(price:GetNumberField(QS_PRC_USER_LAST_VOLUME)))
  print("price:GetNumberField(QS_PRC_USER_LAST_PRICE) = "..tostring(price:GetNumberField(QS_PRC_USER_LAST_PRICE)))
  print("price:GetNumberField(QS_PRC_USER_BID_VOLUME) = "..tostring(price:GetNumberField(QS_PRC_USER_BID_VOLUME)))
  print("price:GetNumberField(QS_PRC_USER_BID_PRICE) = "..tostring(price:GetNumberField(QS_PRC_USER_BID_PRICE)))
  print("price:GetNumberField(QS_PRC_USER_ASK_VOLUME) = "..tostring(price:GetNumberField(QS_PRC_USER_ASK_VOLUME)))
  print("price:GetNumberField(QS_PRC_USER_ASK_PRICE) = "..tostring(price:GetNumberField(QS_PRC_USER_ASK_PRICE)))
  print("price:GetNumberField(QS_PRC_UPDATE_TYPE_BBO) = "..tostring(price:GetNumberField(QS_PRC_UPDATE_TYPE_BBO)))
  print("price:GetNumberField(QS_PRC_UNDERLYING_EXPIRY_SETTLEMENT_PRICE) = "..tostring(price:GetNumberField(QS_PRC_UNDERLYING_EXPIRY_SETTLEMENT_PRICE)))
  print("price:GetNumberField(QS_PRC_TOTAL_TRADE_VOLUME) = "..tostring(price:GetNumberField(QS_PRC_TOTAL_TRADE_VOLUME)))
  print("price:GetNumberField(QS_PRC_TOTAL_TRADE_QTY) = "..tostring(price:GetNumberField(QS_PRC_TOTAL_TRADE_QTY)))
  print("price:GetNumberField(QS_PRC_SETTLEMENT_TYPE) = "..tostring(price:GetNumberField(QS_PRC_SETTLEMENT_TYPE)))
  print("price:GetNumberField(QS_PRC_SETTLEMENT_PRICE) = "..tostring(price:GetNumberField(QS_PRC_SETTLEMENT_PRICE)))
  print("price:GetNumberField(QS_PRC_PREVIOUS_SETTLEMENT_PRICE) = "..tostring(price:GetNumberField(QS_PRC_PREVIOUS_SETTLEMENT_PRICE)))
  print("price:GetNumberField(QS_PRC_OPENING_PRICE) = "..tostring(price:GetNumberField(QS_PRC_OPENING_PRICE)))
  print("price:GetNumberField(QS_PRC_NUM_BID_ORDERS) = "..tostring(price:GetNumberField(QS_PRC_NUM_BID_ORDERS)))
  print("price:GetNumberField(QS_PRC_NUM_ASK_ORDERS) = "..tostring(price:GetNumberField(QS_PRC_NUM_ASK_ORDERS)))
  print("price:GetNumberField(QS_PRC_LAST_TRADE_VOLUME) = "..tostring(price:GetNumberField(QS_PRC_LAST_TRADE_VOLUME)))
  print("price:GetNumberField(QS_PRC_LAST_TRADE_TYPE) = "..tostring(price:GetNumberField(QS_PRC_LAST_TRADE_TYPE)))
  print("price:GetNumberField(QS_PRC_LAST_TRADE_PRICE) = "..tostring(price:GetNumberField(QS_PRC_LAST_TRADE_PRICE)))
  print("price:GetNumberField(QS_PRC_DAILY_LOW_PRICE) = "..tostring(price:GetNumberField(QS_PRC_DAILY_LOW_PRICE)))
  print("price:GetNumberField(QS_PRC_DAILY_HIGH_PRICE) = "..tostring(price:GetNumberField(QS_PRC_DAILY_HIGH_PRICE)))
  print("price:GetNumberField(QS_PRC_CLOSING_PRICE) = "..tostring(price:GetNumberField(QS_PRC_CLOSING_PRICE)))
  print("price:GetNumberField(QS_PRC_BID_FUTURE_LEG_VOLUME) = "..tostring(price:GetNumberField(QS_PRC_BID_FUTURE_LEG_VOLUME)))
  print("price:GetNumberField(QS_PRC_BID_DELTA) = "..tostring(price:GetNumberField(QS_PRC_BID_DELTA)))
  print("price:GetNumberField(QS_PRC_BEST_BID_VOLUME) = "..tostring(price:GetNumberField(QS_PRC_BEST_BID_VOLUME)))
  print("price:GetNumberField(QS_PRC_BEST_BID_PRICE) = "..tostring(price:GetNumberField(QS_PRC_BEST_BID_PRICE)))
  print("price:GetNumberField(QS_PRC_BEST_ASK_VOLUME) = "..tostring(price:GetNumberField(QS_PRC_BEST_ASK_VOLUME)))
  print("price:GetNumberField(QS_PRC_BEST_ASK_PRICE) = "..tostring(price:GetNumberField(QS_PRC_BEST_ASK_PRICE)))
  print("price:GetNumberField(QS_PRC_ASK_FUTURE_LEG_VOLUME) = "..tostring(price:GetNumberField(QS_PRC_ASK_FUTURE_LEG_VOLUME)))
  print("price:GetNumberField(QS_PRC_ASK_DELTA) = "..tostring(price:GetNumberField(QS_PRC_ASK_DELTA)))
  print ("USER BID SOURCE:"..price:GetStringField(QS_PRC_USER_BID_SOURCE));
  print ("USER ASK SOURCE:"..price:GetStringField(QS_PRC_USER_ASK_SOURCE));
  print ("USER LAST SOURCE:"..price:GetStringField(QS_PRC_USER_LAST_SOURCE));
  print ("COMMENT:"..price:GetStringField(QS_PRC_COMMENT));
  print ("USER LAST UPDATE TIME:"..price:GetStringField(QS_PRC_USER_LAST_UPDATE_TIME));
  print ("LAST UPDATE TIME:"..price:GetStringField(QS_PRC_LAST_TRADE_TIME));
  print ("User Price string1:"..price:GetStringField(QS_PRC_USER_STRING1));
  print ("User Price string2:"..price:GetStringField(QS_PRC_USER_STRING2));
  print ("Buyer:"..price:GetStringField(QS_PRC_BUYER));
  print ("Seller:"..price:GetStringField(QS_PRC_SELLER));
  print("price:Product() = "..tostring(price:Product()))
  print("price:UpdateTypeMask() = "..PriceUpdateTypeMaskToString(price:UpdateTypeMask()))
  print("price:Type() = "..PriceTypeToString(price:Type()))
  print("price:OptionalFields() = "..tostring(price:OptionalFields()))
  print("price:Exchange() = "..tostring(price:Exchange()))
  print("price:BestBidPrice() = "..tostring(price:BestBidPrice()))
  print("price:BestAskPrice() = "..tostring(price:BestAskPrice()))
  print("price:LastTradePrice() = "..tostring(price:LastTradePrice()))
  print("price:BestBidVolume() = "..tostring(price:BestBidVolume()))
  print("price:BestAskVolume() = "..tostring(price:BestAskVolume()))
  print("price:LastTradeVolume() = "..tostring(price:LastTradeVolume()))
  print("price:TotalTradeVolume() = "..tostring(price:TotalTradeVolume()))
end

function OnPriceNotify(productPath, fromSnapshot)
print(">>>>>>>>>>Begin the OnPriceNotify Callback<<<<<<<<<<<<<<")

	if fromSnapshot == true then
		print("----------fromSnapshot == true------------")
	else
		print("----------fromSnapshot == false------------")
	end
end

function OnDepth(depth, fromSnapshot)

	print(">>>>>>>>>>Begin the OnDepth Callback<<<<<<<<<<<<<<")

	if fromSnapshot == true then
		print("----------fromSnapshot == true------------")
	else
		print("----------fromSnapshot == false------------")
	end

  print("depth:Exchange() = "..tostring(depth:Exchange()))
  print("depth:ProductPath() = "..tostring(depth:ProductPath()))
  print("depth:Product() = "..tostring(depth:Product()))
  print("depth:ProductName() = "..tostring(depth:ProductName()))
  print("depth:AskDepthCount() = "..tostring(depth:AskDepthCount()))
  print("depth:BidDepthCount() = "..tostring(depth:BidDepthCount()))
  print("depth:AskPrice(0) = "..tostring(depth:AskPrice(0)))
  print("depth:AskVolume(0) = "..tostring(depth:AskVolume(0)))
  print("depth:BidPrice(0) = "..tostring(depth:BidPrice(0)))
  print("depth:BidVolume(0) = "..tostring(depth:BidVolume(0))) 
  print("depth:Ask(0) = "..tostring(depth:Ask(0)))
  print("depth:Bid(0) = "..tostring(depth:Bid(0)))
  print("depth:AccumulativeBid(0) = "..tostring(depth:AccumulativeBid(0)))
  print("depth:AccumulativeAsk(0) = "..tostring(depth:AccumulativeAsk(0)))
end



function OnDepthNotify(productPath1, fromSnapshot)
  print("OnDepthNotify1");
  print("productPath = "..productPath1);
  print(">>>>>>>>>>Begin the OnDepthNotify Callback<<<<<<<<<<<<<<")

	if fromSnapshot == true then
		print("----------fromSnapshot == true------------")
	else
		print("----------fromSnapshot == false------------")
	end
end

function OnLeg(leg, fromSnapshot)
if fromSnapshot == true then
	print("------------fromSnapshot = true --------------")
else
	print("------------fromSnapshot = false ----------=---")
end

print("OnLeg count = "..count)
count = count + 1
  print("leg:CalculatedTradePrice() = "..tostring(leg:CalculatedTradePrice()))
  print("leg:CalculatedTradeVolume() = "..tostring(leg:CalculatedTradeVolume()))
  print("leg:ProductPath() = "..tostring(leg:ProductPath()))
  print("leg:BuySell() = "..tostring(leg:BuySell()))
end

function OnLegNotify(productPath, fromSnapshot)
      print("------------ OnLegNotify begin -------------")
end


