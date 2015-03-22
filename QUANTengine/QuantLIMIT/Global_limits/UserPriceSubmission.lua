
local quantCore = QuantCORE();
local priceManager = quantCore:PriceManager();
local productManager = quantCore:ProductManager();

local productPath="SIM.O.APPLES.FEB2012.70.C.0";

function OnStart()
	--productManager:SubscribeProduct( productPath, false, "");
	priceManager:SubscribePrice( productPath, false, "UserPriceSubmission.lua");
	
	--Build a price object for user price.
	local price = priceManager:BuildUserPrice(productPath);
	
	--Set user price information in the price object.
	price:SetNumberField(QS_PRC_USER_MANUAL,1);
	priceManager:SendUserPrice(price);
	price:SetNumberField(QS_PRC_USER_BID_PRICE,120.50);
	priceManager:SendUserPrice(price);
	price:SetNumberField(QS_PRC_USER_BID_VOLUME,100);
	priceManager:SendUserPrice(price);
	price:SetNumberField(QS_PRC_USER_ASK_PRICE,120.00);
	--priceManager:SendUserPrice(price);
	price:SetNumberField(QS_PRC_USER_ASK_VOLUME,80);
	price:SetNumberField(QS_PRC_USER_LAST_PRICE,121.00);
	price:SetNumberField(QS_PRC_USER_LAST_VOLUME,122);	
	price:SetStringField(QS_PRC_USER_BID_SOURCE,"A");
	price:SetStringField(QS_PRC_USER_ASK_SOURCE,"B");
	price:SetStringField(QS_PRC_USER_LAST_SOURCE,"C");
	price:SetStringField(QS_PRC_COMMENT,"D1");
	
	--Send user price to Reacttor.	
	--priceManager:SendUserPrice(price);
end

function OnStop()
	priceManager:UnsubscribePrice( productPath, false, "UserPriceSubmission.lua");
	--productManager:UnsubscribeProduct( productPath, false, "");
end

function OnPrice( price )
	print ("OnPrice Trigged.");
	
	print ("PRODUCT PATH:"..price:ProductPath());
	print ("USER MANUAL:"..price:GetNumberField(QS_PRC_USER_MANUAL));
	print ("USER BID PRICE:"..price:GetNumberField(QS_PRC_USER_BID_PRICE));
	print ("USER BID VOLUME:"..price:GetNumberField(QS_PRC_USER_BID_VOLUME));
	print ("USER ASK PRICE:"..price:GetNumberField(QS_PRC_USER_ASK_PRICE));
	print ("USER ASK VOLUME:"..price:GetNumberField(QS_PRC_USER_ASK_VOLUME));
	print ("USER LAST PRICE:"..price:GetNumberField(QS_PRC_USER_LAST_PRICE));
	print ("USER LAST VOLUME:"..price:GetNumberField(QS_PRC_USER_LAST_VOLUME));
	
	print ("USER BID SOURCE:"..price:GetStringField(QS_PRC_USER_BID_SOURCE));
	print ("USER ASK SOURCE:"..price:GetStringField(QS_PRC_USER_ASK_SOURCE));
	print ("USER LAST SOURCE:"..price:GetStringField(QS_PRC_USER_LAST_SOURCE));
	print ("COMMENT:"..price:GetStringField(QS_PRC_COMMENT));
end