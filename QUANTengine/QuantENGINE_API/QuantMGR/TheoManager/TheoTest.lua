local QuantCORE = QuantCORE()
local TheoManager = QuantCORE:TheoManager()
local timer_Id=100
local timer_Interval=5000
local productPath = "SIM.O.XJO.STRATEGIES.TIGHT.TMC.BUY.1-0.[SIM.O.XJO.DEC2013.4050.C.0].SELL.1-0.[SIM.O.XJO.DEC2013.4375.C.0].BUY.1-0.[SIM.O.XJO.DEC2013.4500.C.0]"
local pricingSpec = "QA_XJO_MAC1"

function OnStart()

	TheoManager:SubscribeTheo(productPath, pricingSpec, false, "TheoTest.lua")
	--TheoManager:SubscribeTheo(productPath, pricingSpec, true, "TheoTest.lua")
	
	local theoTable = TheoManager:SnapshotTheo(QS_PUBLIC_UPDATE, productPath, "")
	--local theoTable = TheoManager:SnapshotTheo(QS_PRIVATE_MODIFIED_UPDATE, productPath, "")
	--local theoTable = TheoManager:SnapshotTheo(QS_PRIVATE_UNMODIFIED_REFRESH, productPath, "")
	--local theoTable = TheoManager:SnapshotTheo(QS_PUBLIC_END_OF_DAY_UPDATE, productPath, "")	
	
	if theoTable ~= nil then
		for k, v in pairs(theoTable) do
			print("k = "..tostring(k))
			print("v = "..tostring(v))
		end
	end
	
	local TheoJobCalculationModifier = TheoManager:BuildTheoReferenceModifier()
	
	print("TheoJobCal:InterestRate() "..tostring(TheoJobCalculationModifier:InterestRate()))
	print("TheoJobCal:Volatility() "..tostring(TheoJobCalculationModifier:Volatility()))
	print("TheoJobCal:TimeToExpiry() "..tostring(TheoJobCalculationModifier:TimeToExpiry()))
	print("TheoJobCal:Underlying() "..tostring(TheoJobCalculationModifier:Underlying()))
	
	print("------------------------------------------------------------")
	
	TheoJobCalculationModifier:InterestRate(5590.5)
	TheoJobCalculationModifier:Volatility(5590.5)
	TheoJobCalculationModifier:TimeToExpiry(20130704)
	TheoJobCalculationModifier:Underlying(5600.05)
	
	print("TheoJobCal:InterestRate() "..tostring(TheoJobCalculationModifier:InterestRate()))
	print("TheoJobCal:Volatility() "..tostring(TheoJobCalculationModifier:Volatility()))
	print("TheoJobCal:TimeToExpiry() "..tostring(TheoJobCalculationModifier:TimeToExpiry()))
	print("TheoJobCal:Underlying() "..tostring(TheoJobCalculationModifier:Underlying()))
	
	print("------------------------------------------------------------")
	
	print("TheoJobCal:InterestRateModifierType() "..tostring(TheoJobCalculationModifier:InterestRateModifierType()))
	print("TheoJobCal:VolatilityModifierType() "..tostring(TheoJobCalculationModifier:VolatilityModifierType()))
	print("TheoJobCal:TimeToExpiryModifierType() "..tostring(TheoJobCalculationModifier:TimeToExpiryModifierType()))
	print("TheoJobCal:UnderlyingModifierType() "..tostring(TheoJobCalculationModifier:UnderlyingModifierType()))
	
	print("------------------------------------------------------------")
	
	TheoJobCalculationModifier:InterestRateModifierType(1)
	TheoJobCalculationModifier:VolatilityModifierType(1)
	TheoJobCalculationModifier:TimeToExpiryModifierType(1)
	TheoJobCalculationModifier:UnderlyingModifierType(1)
	
	print("TheoJobCal:InterestRateModifierType() "..tostring(TheoJobCalculationModifier:InterestRateModifierType()))
	print("TheoJobCal:VolatilityModifierType() "..tostring(TheoJobCalculationModifier:VolatilityModifierType()))
	print("TheoJobCal:TimeToExpiryModifierType() "..tostring(TheoJobCalculationModifier:TimeToExpiryModifierType()))
	print("TheoJobCal:UnderlyingModifierType() "..tostring(TheoJobCalculationModifier:UnderlyingModifierType()))
	
	local RunTheoJob = TheoManager:RunTheoJob(pricingSpec, TheoJobCalculationModifier)
	if RunTheoJob == true then
		print("---------------> RunTheoJob success <--------------")
	else 
		print("---------------> RunTheoJon failed <---------------")
	end
		
--  Timer(timer_Id,timer_Interval,"TheoTest.lua")
end
--[[
function OnTimer(id)
  SendCompletionCode(QS_COMPLETION_CODE_SUCCESS,"Timer Out")
end 
--]]


function OnStop()
  TheoManager:UnsubscribeTheo(productPath, pricingSpec, false, "TheoTest.lua")
  --TheoManager:UnsubscribeTheo(productPath, pricingSpec, true, "TheoTest.lua")
end

function OnTheo(theo, fromSnapshot)
  print("--------------------------------------------")
  
  print("theo:Rent() = "..tostring(theo:Rent()))
  print("theo:DeltaBS() = "..tostring(theo:DeltaBS()))
  print("theo:Vanna() = "..tostring(theo:Vanna()))
  print("theo:Vomma() = "..tostring(theo:Vomma()))
  print("theo:RateTheta() = "..tostring(theo:RateTheta()))
  print("theo:VolTheta() = "..tostring(theo:VolTheta()))
  print("theo:AltTheoPrice() = "..tostring(theo:AltTheoPrice()))
  print("theo:Speed() = "..tostring(theo:Speed()))
  print("theo:VarVega() = "..tostring(theo:VarVega()))
  
  
  print("--------------------------------------------")
  
  print("theo:ProductPath() = "..tostring(theo:ProductPath()))
  print("theo:PricingSpec()= "..tostring(theo:PricingSpec()))
  print("theo:ProductName() = "..tostring(theo:ProductName()))
  print("theo:Product() = "..tostring(theo:Product()))
  print("theo:TheoPrice() = "..tostring(theo:TheoPrice()))
  print("theo:Delta() = "..tostring(theo:Delta()))
  print("theo:Gamma() = "..tostring(theo:Gamma()))
  print("theo:Vega() = "..tostring(theo:Vega()))
  print("theo:Theta() = "..tostring(theo:Theta()))
  print("theo:Rho() = "..tostring(theo:Rho()))
  print("theo:Divit() = "..tostring(theo:Divit()))
  print("theo:Charm() = "..tostring(theo:Charm()))
  print("theo:ImpliedVolatilityMid() = "..tostring(theo:ImpliedVolatilityMid()))
  print("theo:ImpliedVolatilityLastIsValid() = "..tostring(theo:ImpliedVolatilityLastIsValid()))
  print("theo:ImpliedVolatilityLast() = "..tostring(theo:ImpliedVolatilityLast()))
  print("theo:ImpliedVolatilityMidIsValid() = "..tostring(theo:ImpliedVolatilityMidIsValid()))
  print("theo:Volatility() = "..tostring(theo:Volatility()))
  print("theo:UnderlyingPrice() = "..tostring(theo:UnderlyingPrice()))
  print("theo:InterestRate() = "..tostring(theo:InterestRate()))
  print("theo:TimeToExpiry() = "..tostring(theo:TimeToExpiry()))
  print("theo:TimeToExpiryBD() = "..tostring(theo:TimeToExpiryBD()))
  print("theo:CostOfCarry() = "..tostring(theo:CostOfCarry()))
  print("theo:ForwardPrice() = "..tostring(theo:ForwardPrice()))
  print("theo:UserTheo1() = "..tostring(theo:UserTheo1()))
  print("theo:UserTheo2() = "..tostring(theo:UserTheo2()))
  print("theo:TheoUpdates() = "..tostring(theo:TheoUpdates()))
  
  if fromSnapshot == true then
  	print("-----------------fromSnapshot = True--------------------")
  else
  	print("-----------------fromSnapshot = false-------------------")
  end
  
  
  print("-------------------------------------------------------------------")
  print("Begin to verify the void type methods")
  print("-------------------------------------------------------------------")
  
  theo:ProductID("SIM.O.XJO.JUN2013.2500.C.0") 
  print("theo:ProductID.Product ="..tostring(theo:Product()))
  print("theo:ProductID.ProductPath ="..tostring(theo:ProductPath()))
  print("theo:ProductID.ProductName ="..tostring(theo:ProductName()))
  
  theo:TheoPrice(3000.75)
  print("theo:TheoPrice ="..tostring(theo:TheoPrice()))
  
  theo:Delta(3000.75)
  print("theo:Delta() = "..tostring(theo:Delta()))
  
  theo:Gamma(3000.75)
  print("theo:Gamma() = "..tostring(theo:Gamma()))
  
  theo:Theta(3000.75)
  print("theo:Theta() = "..tostring(theo:Theta()))
  
  theo:Vega(3000.75)
  print("theo:Vega() = "..tostring(theo:Vega()))
  
  theo:Rho(3000.75)
  print("theo:Rho() = "..tostring(theo:Rho()))
  
  theo:Divit(3000.75)
  print("theo:Divit() = "..tostring(theo:Divit()))
  
  theo:Charm(3000.75)
  print("theo:Charm() = "..tostring(theo:Charm()))
  
  theo:ImpliedVolatilityMid(5555555)
  print("theo:ImpliedVolatilityMid() = "..tostring(theo:ImpliedVolatilityMid()))
 
  theo:ImpliedVolatilityLast(66666666)
  print("theo:ImpliedVolatilityLast() = "..tostring(theo:ImpliedVolatilityLast()))
  
  theo:Volatility(777777)
  print("theo:Volatility() = "..tostring(theo:Volatility()))
  
  theo:UnderlyingPrice(22222)
  print("theo:UnderlyingPrice() = "..tostring(theo:UnderlyingPrice()))
  
  theo:InterestRate(190)
  print("theo:InterestRate() = "..tostring(theo:InterestRate()))
  
  theo:TimeToExpiry(20120930)
  print("theo:TimeToExpiry() = "..tostring(theo:TimeToExpiry()))
  
  theo:TimeToExpiryBD(20120929)
  print("theo:TimeToExpiryBD() = "..tostring(theo:TimeToExpiryBD()))
  
  theo:CostOfCarry(2)
  print("theo:CostOfCarry() = "..tostring(theo:CostOfCarry()))
  
  theo:ForwardPrice(3000.00)
  print("theo:ForwardPrice() = "..tostring(theo:ForwardPrice()))
  
  theo:UserTheo1(1000)
  print("theo:UserTheo1() = "..tostring(theo:UserTheo1()))
  
  theo:UserTheo2(550)
  print("theo:UserTheo2() = "..tostring(theo:UserTheo2()))
    
end

function OnTheoNotify(theo, fromSnapshot)
	  print("--------------OnTheoNotify Begins-----------------")
	  print("--------------OnTheoNotify Begins-----------------")
	  print("--------------OnTheoNotify Begins-----------------")
	  print("--------------OnTheoNotify Begins-----------------")
	  print("--------------OnTheoNotify Begins-----------------")
end