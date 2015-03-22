local quantCore = QuantCORE()
local machineManager = quantCore:MachineManager()
local productManager = quantCore:ProductManager()
local productPath = "SIM.O.XJO.SEP2013.2300.C.0"
--local productPath = "SIM.O.XJO.STRATEGIES.TIGHT.TMC.BUY.1-0.[SIM.O.XJO.JUN2013.4775.P.0].SELL.1-0.[SIM.O.XJO.JUN2013.5000.C.0]"
local specName = "MQ5_XJO_MAC1"
--local productPath = "SIM.F.XJO.>"

function OnStart()

	machineManager:SubscribeMachine(productPath, specName, true, "MachineManagerTest.lua")
	
	local EdgeUpTbl = machineManager:GetEdgeUpdate(productPath, specName)
	if EdgeUpTbl ~= nil then
		for EUkey, EUValue in pairs(EdgeUpTbl) do
			print("EUKey ="..tostring(EUkey))
			print("EUValue ="..tostring(EUValue))
		end
	else
		print("---------------EdgeUpTbl is nil---------------")
	end
	
	local LimitUpTbl = machineManager:GetLimitUpdate(productPath, specName)
	if LimitUpTbl ~= nil then
		for LUkey, LUValue in pairs(LimitUpTbl) do
			print("LUkey ="..tostring(LUkey))
			print("LUValue ="..tostring(LUValue))
		end
	else
		print("---------------LimitUpTbl is nil--------------")
	end
		
		

end

function OnStop()
	machineManager:UnsubscribeMachine(productPath, specName, true, "MachineManagerTest.lua")

end


function OnEdgeUpdate(takeoutEdge, fromSnapshot)
	print("------------OnEdgeUpade------------")
	
	if fromSnapshot == true then
		print("------------fromSnapshot is true--------------")
	else
		print("------------fromSnapshot is false-------------")
	end
	
	print("ProductPath -->"..tostring(takeoutEdge:ProductPath()))
	print("SpecName -->"..tostring(takeoutEdge:SpecName()))
	print("AskEdge -->"..tostring(takeoutEdge:AskEdge()))
	print("BidEdge -->"..tostring(takeoutEdge:BidEdge()))
	print("ACAskEdge -->"..tostring(takeoutEdge:ACAskEdge()))
	print("ACBidEdge -->"..tostring(takeoutEdge:ACBidEdge()))
	print("Tolerance -->"..tostring(takeoutEdge:Tolerance()))
	print("BidDime -->"..tostring(takeoutEdge:BidDime()))
	print("AskDime -->"..tostring(takeoutEdge:AskDime()))
	print("BidMatch -->"..tostring(takeoutEdge:BidMatch()))
	print("AskMatch -->"..tostring(takeoutEdge:AskMatch()))
	print("SpreadUnit -->"..tostring(takeoutEdge:SpreadUnit()))
end

function OnEdgeUpdateNotify(productPath, specName, fromSnapshot)
	print("---------OnEdgeUpdateNotify begins----------")
	
	if fromSnapshot == true then
		print("------------fromSnapshot is true--------------")
	else
		print("------------fromSnapshot is false-------------")
	end
end

function OnLimitUpdate(takeoutLimit, fromSnapshot)
	print("---------OnLimitUpdate----------")
	
	if fromSnapshot == true then
		print("------------fromSnapshot is true--------------")
	else
		print("------------fromSnapshot is false-------------")
	end
	
	print("ProductPath ="..tostring(takeoutLimit:ProductPath()))
	print("SpecName ="..tostring(takeoutLimit:SpecName()))
	print("Limit ="..tostring(takeoutLimit:Limit()))
	
	if takeoutLimit:IsOn() == true then
		print("--------------the flag isOn of the rsTakeoutlimit is true---------------")
	else
		print("--------------the flag isOn of the rsTakeoutlimit is false---------------")
	end
	
	if takeoutLimit:IsBroken() == true then
		print("--------------the flag isBroken of the rsTakeoutlimit is true---------------")
	else
		print("--------------the flag isBroken of the rsTakeoutlimit is false---------------")
	end
	
	if takeoutLimit:IsPreHedgeOn() == true then
		print("--------------the flag isPreHedgeOn of the rsTakeoutlimit is true---------------")
	else
		print("--------------the flag isPreHedgeOn of the rsTakeoutlimit is false---------------")
	end
	
	
end


function OnLimitUpdateNotify(productPath, specName, fromSnapshot)
	print("---------OnLimitUpdateNotify begins----------")
	
	if fromSnapshot == true then
		print("------------fromSnapshot is true--------------")
	else
		print("------------fromSnapshot is false-------------")
	end
end