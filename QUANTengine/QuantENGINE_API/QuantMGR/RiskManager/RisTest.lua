--before running the scripts, user need to trade orders to trigger the product's risk
local QuantCORE = QuantCORE()
local RiskManager=QuantCORE:RiskManager()
local productPath = "SIM.O.XJO.SEP2013.2300.C.0"
local pricingSpec = "QA_XJO_MAC1"
--local pricingSpec = nil

function OnStart()
    RiskManager:SubscribeRisk(productPath, "xuliang1", pricingSpec, true, "RisTest.lua")
--  Timer(timer_Id,timer_Interval,"RiskTest.lua")
	local RiskTbl = RiskManager:SnapshotRisk(productPath, "xuliang1", pricingSpec, QS_PUBLIC_UPDATE)
--	local RiskTbl = RiskManager:SnapshotRisk(productPath, "xuliang1", pricingSpec, QS_PRIVATE_MODIFIED_UPDATE)
--	local RiskTbl = RiskManager:SnapshotRisk(productPath, "xuliang1", pricingSpec, QS_PRIVATE_UNMODIFIED_REFRESH)
--	local RiskTbl = RiskManager:SnapshotRisk(productPath, "", pricingSpec, QS_PUBLIC_END_OF_DAY_UPDATE)
	
	if RiskTbl ~= nil then
		for k, v in pairs(RiskTbl) do
			print("=============>[RiskTbl] --> k = "..tostring(k))
			print("=============>[RiskTbl] --> v = "..tostring(v))
			--[[
			print("~~~~~~~~~~RiskTbl:Product()="..tostring(RiskTbl:Product()))
  			print("~~~~~~~~~~RiskTbl:PricingSpec()="..tostring(RiskTbl:PricingSpec()))
  			print("~~~~~~~~~~RiskTbl:Account()="..tostring(RiskTbl:Account()))
  			print("~~~~~~~~~~RiskTbl:RiskPosition()="..tostring(RiskTbl:RiskPosition()))
  			print("~~~~~~~~~~RiskTbl:RiskDelta()="..tostring(RiskTbl:RiskDelta()))
  			print("~~~~~~~~~~RiskTbl:RiskCashDelta()="..tostring(RiskTbl:RiskCashDelta()))
  			print("~~~~~~~~~~RiskTbl:RiskGamma()="..tostring(RiskTbl:RiskGamma()))
  			print("~~~~~~~~~~RiskTbl:RiskCashGamma()="..tostring(RiskTbl:RiskCashGamma()))
  			print("~~~~~~~~~~RiskTbl:RiskTheta()="..tostring(RiskTbl:RiskTheta()))
  			print("~~~~~~~~~~RiskTbl:RiskVega()="..tostring(RiskTbl:RiskVega()))
  			print("~~~~~~~~~~RiskTbl:RiskRho()="..tostring(RiskTbl:RiskRho()))
  			print("~~~~~~~~~~RiskTbl:RiskDivit()="..tostring(RiskTbl:RiskDivit()))
  			print("~~~~~~~~~~RiskTbl:RiskCharm()="..tostring(RiskTbl:RiskCharm()))
  			print("~~~~~~~~~~RiskTbl:Premium()="..tostring(RiskTbl:Premium()))
  			print("~~~~~~~~~~RiskTbl:TotalProfitAndLoss()="..tostring(RiskTbl:TotalProfitAndLoss()))
  			print("~~~~~~~~~~RiskTbl:TradeprofitAndLoss()="..tostring(RiskTbl:TradeProfitAndLoss()))
  			print("~~~~~~~~~~RiskTbl:OpenProfitAndLoss()="..tostring(RiskTbl:OpenProfitAndLoss()))
  			print("~~~~~~~~~~RiskTbl:DailyProfitAndLoss()="..tostring(RiskTbl:DailyProfitAndLoss()))
  			print("~~~~~~~~~~RiskTbl:RiskUpdates()="..tostring(RiskTbl:RiskUpdates()))
  			--]]
		end

	else
		print(">>>>>>>>>>the RiskTbl is nil<<<<<<<<<<<")
	end
	

end

function OnRisk(risk)
  print("risk:Product()="..tostring(risk:Product()))
  print("risk:PricingSpec()="..tostring(risk:PricingSpec()))
  print("risk:Account()="..tostring(risk:Account()))
  print("risk:RiskPosition()="..tostring(risk:RiskPosition()))
  print("risk:RiskDelta()="..tostring(risk:RiskDelta()))
  print("risk:RiskCashDelta()="..tostring(risk:RiskCashDelta()))
  print("risk:RiskGamma()="..tostring(risk:RiskGamma()))
  print("risk:RiskCashGamma()="..tostring(risk:RiskCashGamma()))
  print("risk:RiskTheta()="..tostring(risk:RiskTheta()))
  print("risk:RiskVega()="..tostring(risk:RiskVega()))
  print("risk:RiskRho()="..tostring(risk:RiskRho()))
  print("risk:RiskDivit()="..tostring(risk:RiskDivit()))
  print("risk:RiskCharm()="..tostring(risk:RiskCharm()))
  print("risk:Premium()="..tostring(risk:Premium()))
  print("risk:TotalProfitAndLoss()="..tostring(risk:TotalProfitAndLoss()))
  print("risk:TradeprofitAndLoss()="..tostring(risk:TradeProfitAndLoss()))
  print("risk:OpenProfitAndLoss()="..tostring(risk:OpenProfitAndLoss()))
  print("risk:DailyProfitAndLoss()="..tostring(risk:DailyProfitAndLoss()))
  print("risk:RiskUpdates()="..tostring(risk:RiskUpdates()))
end

function OnRiskNotify(productPath, pricingSpec, account, fromSnapshot )
	print("---------> the OnRiskNotify begins !")
	print("productPath = "..tostring(productPath))
	print("pricingSpec = "..tostring(pricingSpec))
	print("account = "..tostring(account))
end


--[[
function OnTimer(id)
  SendCompletionCode(QS_COMPLETION_CODE_SUCCESS,"Timer Out")
end 
--]]
function OnStop()
  --RiskManager:UnsubscribeRisk(productPath, "xuliang1", pricingSpec,false,"RisTest.lua")
  RiskManager:UnsubscribeRisk(productPath, "xuliang1", pricingSpec,true,"RisTest.lua")
end

