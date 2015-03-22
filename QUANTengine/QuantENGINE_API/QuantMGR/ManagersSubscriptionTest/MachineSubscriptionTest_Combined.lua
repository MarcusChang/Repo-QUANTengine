
local __script = "MachineSubscriptionTest_Combined.lua"

local machines = { }
local productPath = "SIM.O.NK.JUN2013.10000.C.0"


local QuantCORE = QuantCORE()
local AttManager = QuantCORE:AttManager()
local MachineManager = QuantCORE:MachineManager()

local ProductManager = QuantCORE:ProductManager()
local PriceManager = QuantCORE:PriceManager()
local TheoManager = QuantCORE:TheoManager()
local OrderManager = QuantCORE:OrderManager()
local PositionManager = QuantCORE:PositionManager()
local RiskManager = QuantCORE:RiskManager()
local TradeManager = QuantCORE:TradeManager()
local TheoCubeManager = QuantCORE:TheoCubeManager()
local LimitManager = QuantCORE:LimitManager()
local ParameterManager = QuantCORE:ParameterManager()
local RFQManager = QuantCORE:RFQManager()

local startday = Date:FromString("20130301")
local endday = Date:FromString("20130301")


function OnStart()
	
	machines[1] = "TOM_SGX_MAC1"
	machines[2] = "MQ5_SGX_MAC1"
	machines[3] = "MQ_SGX_MAC1"
	machines[4] = "RFQ_SGX_MAC1"
	machines[5] = "RFQ_NK_MAC1"
	
	for i=1, #machines do
		local machineName = machines[i]
		LOG("Creating machine subscription for "..tostring(productPath)..", "..tostring(machineName), LOG_ERR)
		MachineManager:SubscribeMachine(productPath, machineName, false, __script)
		MachineManager:SubscribeMachine(productPath, machineName, true, __script)
		
		AttManager:SubscribeAtt(machineName, false, __script)
		AttManager:SubscribeAtt(machineName, true, __script)
		
		ProductManager:SubscribeProduct(productPath, false, __script)
		ProductManager:SubscribeProduct(productPath, true, __script)
		
		PriceManager:SubscribePrice(productPath, false, __script)
		PriceManager:SubscribePrice(productPath, true, __script)
		
		PriceManager:SubscribeDepth(productPath, false, __script)
		PriceManager:SubscribeDepth(productPath, true, __script)
		
		
		TheoManager:SubscribeTheo(productPath, "QA_NK_MAC1", false, __script)
		TheoManager:SubscribeTheo(productPath, "QA_NK_MAC1", true, __script)
		
		OrderManager:SubscribeOrder(productPath, "Marcus_Chang", false, false, __script)
		OrderManager:SubscribeOrder(productPath, "Marcus_Chang", true, true, __script)
		
		 
		PositionManager:SubscribePosition(productPath, "xuliang1", false, __script)
		PositionManager:SubscribePosition(productPath, "xuliang1", true, __script)
		
		RiskManager:SubscribeRisk(productPath, "xuliang1", "QA_NK_MAC1", false, __script)
		RiskManager:SubscribeRisk(productPath, "xuliang1", "QA_NK_MAC1", true, __script)
		
		TradeManager:SubscribeTrade(productPath, "xuliang1", startday, endday, false, __script)
		TradeManager:SubscribeTrade(productPath, "xuliang1", startday, endday, true, __script)
		
		RFQManager:SubscribeRFQ(productPath, false, __script)
		RFQManager:SubscribeRFQ(productPath, true, __script)
		
		
		local PMstpTbl = PriceManager:SnapshotPrice(productPath, QS_PRICE_LAST_UPDATE)
		if PMstpTbl ~= nil then
			for kp1, vp1 in pairs(PMstpTbl) do
				LOG("[i] = "..tostring(i).." ; kp1 and vp1 in PMstpTbl ->"..tostring(kp1).."="..tostring(vp1), LOG_ERR)
			end
		end
		
		local PMstdTbl = PriceManager:SnapshotDepth(productPath)
		if PMstdTbl ~= nil then
			for kp2, vp2 in pairs(PMstdTbl) do
				LOG("[i] = "..tostring(i).." ; kp2 and vp2 in PMstdTbl ->"..tostring(kp2).."="..tostring(vp2), LOG_ERR)
			end
		end
		
		local PMstlTbl = PriceManager:SnapshotLeg(productPath)
		if PMstlTbl ~= nil then
			for kp3, vp3 in pairs(PMstdTbl) do
				LOG("[i] = "..tostring(i).." ; kp3 and vp3 in PMstlTbl ->"..tostring(kp3).."="..tostring(vp3), LOG_ERR)
			end
		end
		
		local PMstduTbl = ProductManager:SnapshotProduct(productPath)
		if PMstduTbl ~= nil then
			for kp4, vp4 in pairs(PMstduTbl) do
				LOG("[i] = "..tostring(i).." ; kp4 and vp4 in PMstduTbl ->"..tostring(kp4).."="..tostring(vp4), LOG_ERR)
			end
		end
		
		
		local OMstOTbl = OrderManager:SnapshotOrder(productPath, "Marcus_Chang", false, false)
		if OMstduTbl ~= nil then
			for kp5, vp5 in pairs(OMstOTbl) do
				LOG("[i] = "..tostring(i).." ; kp5 and vp5 in OMstOTbl ->"..tostring(kp5).."="..tostring(vp5), LOG_ERR)
			end
		end	
		
		
		local PMstPOTbl = PositionManager:SnapshotPosition(productPath, "xuliang1")
		if PMstPOTbl ~= nil then
			for kp6, vp6 in pairs(PMstPOTbl) do
				LOG("[i] = "..tostring(i).." ; kp6 and vp6 in PMstPOTbl ->"..tostring(kp6).."="..tostring(vp6), LOG_ERR)
			end
		end
		
		local RMstRbl = RiskManager:SnapshotRisk(productPath, "xuliang1", "QA_NK_MAC1", QS_PUBLIC_UPDATE)
		if RMstRbl ~= nil then
			for kp7, vp7 in pairs(RMstRbl) do
				LOG("[i] = "..tostring(i).." ; kp7 and vp7 in RMstRbl ->"..tostring(kp7).."="..tostring(vp7), LOG_ERR)
			end
		end
		
		local TMstTbl = TradeManager:SnapshotTrade(productPath, "xuliang1", startday, endday)
		if TMstTbl ~= nil then
			for kp8, vp8 in pairs(TMstTbl) do
				LOG("[i] = "..tostring(i).." ; kp8 and vp8 in TMstTbl ->"..tostring(kp8).."="..tostring(vp8), LOG_ERR)
			end
		end
		
		local RMstRbl = RFQManager:SnapshotRFQs(productPath)
		if RMstRbl ~= nil then
			for kp9, vp9 in pairs(RMstRbl) do
				LOG("[i] = "..tostring(i).." ; kp9 and vp9 in RMstRbl ->"..tostring(kp9).."="..tostring(vp9), LOG_ERR)
			end
		end
		
		local TMsttTbl = TheoManager:SnapshotTheo(QS_PUBLIC_UPDATE, productPath, "QA_NK_MAC1")
		if TMsttTbl ~= nil then
			for kp10, vp10 in pairs(TMsttTbl) do
				LOG("[i] = "..tostring(i).." ; kp10 and vp10 in TMsttTbl->"..tostring(kp10).."="..tostring(vp10), LOG_ERR)
			end
		end			
		
	end
	
end

function OnStop()
end

function OnATTLimitUpdate(takeoutLimitBroadcast, fromSnapshot)
	if (takeoutLimitBroadcast ~= nil) then
		LOG("ATTLimit:"..tostring(takeoutLimitBroadcast:GetGlobalContractLimit()), LOG_ERR)
	end 
end


function OnATTLimitUpdateNotify(specName, fromSnapshot)
	if (specName ~= nil) then
		LOG("----------->[ATT] OnATTLimitUpdateNotify", LOG_ERR)
	end 
end



function OnLimitUpdate(TakeoutLimit, fromSnapshot)
	if (TakeoutLimit ~= nil) then	
		LOG("LIMIT:"..tostring(TakeoutLimit:ProductPath()).."  "..tostring(TakeoutLimit:SpecName()), LOG_ERR)	
	end
end


function OnLimitUpdateNotify(productPath, specName, fromSnapshot)
	if (productPath ~= nil) then	
		LOG("----------->[MachineManager] LIMIT Notify", LOG_ERR)	
	end
end


function OnEdgeUpdate(TakeoutEdge, fromSnapshot)
	if (TakeoutEdge ~= nil) then
		LOG("EDGE:"..tostring(TakeoutEdge:ProductPath()).."  "..tostring(TakeoutEdge:SpecName()), LOG_ERR)
	end
end

function OnEdgeUpdateNotify(productPath, specName, fromSnapshot)
	if (specName ~= nil) then
		LOG("----------->[MachineManager] EDGE Notify", LOG_ERR)
	end
end


function OnProduct(product, fromSnapshot)
	if (product ~= nil) then
		LOG("[product] ProductName ="..tostring(product:ProductName()), LOG_ERR)
	end
end

function OnProductNotify(productPath, fromSnapshot)
	if (productPath ~= nil) then
		LOG("----------->[product] OnProductNotify", LOG_ERR)
	end
end


function OnPrice(price, fromSnapshot)
	if (price ~= nil) then
		LOG("[price] ProductPath ="..tostring(price:ProductPath()), LOG_ERR)
	end
end

function OnPriceNotify(productPath, fromSnapshot)
	if (productPath ~= nil) then
		LOG("----------->[price] OnPriceNotify", LOG_ERR)
	end
end


function OnDepth(depth, fromSnapshot)
	if (depth ~= nil) then
		LOG("[depth] ProductPath ="..tostring(depth:ProductPath()), LOG_ERR)
	end
end

function OnDepthNotify(productPath, fromSnapshot)
	if (productPath ~= nil) then
		LOG("----------->[depth] OnDepthNotify", LOG_ERR)
	end
end


function OnOrder(order, isRemoved, fromSnapshot)
	if (order ~= nil) then
		LOG("[order] ExchangeAccount ="..tostring(order:ExchangeAccount()), LOG_ERR)
	end
end

function OnOrderNotify(productPath, orderID, isRemoved, fromSnapshot)
	if (productPath ~= nil) then
		LOG("----------->[order] OnOrderNotify", LOG_ERR)
	end
	
end


function OnPosition(position, fromSnapshot)
	if (position ~= nil) then
		LOG("[position] ProductPath ="..tostring(position:ProductPath()), LOG_ERR)
	end
end

function OnPositionNotify(productPath, account, fromSnapshot)
	if (account ~= nil) then
		LOG("----------->[position] OnPositionNotify", LOG_ERR)
	end
end


function OnRisk(risk, QS_PUBLIC_UPDATE, fromSnapshot)
	if (risk ~= nil) then
		LOG("[risk] Account ="..tostring(risk:Account()), LOG_ERR)
	end
end

function OnRiskNotfiy(productPath, pricingSpec, account, fromSnapshot)
	if (pricingSpec ~= nil) then
		LOG("------------>[risk] OnRiskNotfiy", LOG_ERR)
	end
end


function OnTrade(trade, fromSnapshot)
	if (trade ~= nil) then
		LOG("[trade] Product ="..tostring(trade:Product()), LOG_ERR)
	end
end

function OnTradeNotify(productPath, tradeID, fromSnapshot)
	if (productPath ~= nil) then
		LOG("------------>[trade] OnTradeNotify", LOG_ERR)
	end
end


function OnRFQUpdate(request)
	if (request ~= nil) then
		LOG("[RFQ] ProductPath ="..tostring(request:ProductPath()), LOG_ERR)
	end
end


function OnRFQUpdateNotify(productPath, fromSnapshot)
	if (productPath ~= nil) then
		LOG("------------>[RFQ] OnRFQUpdateNotify", LOG_ERR)
	end
end

function OnTheo(theo, QS_PUBLIC_UPDATE, fromSnapshot)
	if (theo ~= nil) then
		LOG("[Theo] TheoPrice ="..tostring(theo:TheoPrice()), LOG_ERR)
	end
end

function OnTheoNotify(productPath, pricingSpec, fromSnapshot)
	if (productPath ~= nil) then
		LOG("------------>[Theo] OnTheoNotify", LOG_ERR)
	end
end