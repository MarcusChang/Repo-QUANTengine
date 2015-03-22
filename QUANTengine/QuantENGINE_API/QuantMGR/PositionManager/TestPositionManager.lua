local QuantCORE = QuantCORE()
local PositionManager = QuantCORE:PositionManager()
local productPath1 = "SIM.O.XJO.STRATEGIES.TIGHT.TMC.BUY.1-0.[SIM.O.XJO.MAY2013.4175.C.0].BUY.1-0.[SIM.O.XJO.MAY2013.4250.C.0].BUY.1-0.[SIM.O.XJO.MAY2013.4375.C.0]"
local productPath2 = "SIM.O.XJO.MAY2013.4650.C.0"
local productPath3 = "SIM.F.XJO.JUN2013"
local productPath4 = "SIM.O.>"



function OnStart()
	PositionManager:SubscribePosition(productPath4, "", false, "TestPositionManager.lua")

	local snapTable = PositionManager:SnapshotPosition(productPath4, "")
	if snapTable ~= nil then
		for k,v in pairs(snapTable) do
			print("snapTable key -->"..tostring(k))
			print("snapTable value -->"..tostring(v))
		end
	else 
		print("--------snapTable is nil-------")
	end

end

function OnPosition(position, fromSnapshot)
	print("-----------------OnPosition begins----------------")
	if fromSnapshot == true then 
		print("----------fromSnapshot = true----------")
	else
		print("----------fromSnapshot = false---------")
	end

  print("position:AccountCode() = "..tostring(position:AccountCode()))
  print("position:Product() = "..tostring(position:Product()))
  print("position:NetPosition() = "..tostring(position:NetPosition()))
  print("position:BuyCosts() = "..tostring(position:BuyCosts()))
  print("position:SellRevenues() = "..tostring(position:SellRevenues()))
  print("position:Turnover() = "..tostring(position:Turnover()))
  print("position:DailyTurnover() = "..tostring(position:DailyTurnover()))
  print("position:EODPosition() = "..tostring(position:EODPosition()))
  print("position:EODBuyCosts() = "..tostring(position:EODBuyCosts()))
  print("position:EODSellRevenues() = "..tostring(position:EODSellRevenues()))
  print("position:EODTurnover() = "..tostring(position:EODTurnover()))
  print("position:VersionNumber() = "..tostring(position:VersionNumber()))
  print("position:TimeStamp() = "..tostring(position:TimeStamp()))
  
  print("-----------------OnPosition end -------------------")
    
end

function OnPositionNotify(productPath, account, fromSnapshot)
	print("--------OnPositionNotify begins---------")
	
	if fromSnapshot == true then 
		print("----------fromSnapshot = true----------")
	else
		print("----------fromSnapshot = false---------")
	end
	 
end



function OnStop()
PositionManager:UnsubscribePosition(productPath4,"",false,"TestPositionManager.lua")
end