local quantCore = QuantCORE();
local ParameterManager = quantCore:ParameterManager();
local spec_name = "QA_XJOMOCK_DH";


function OnStart()
	ParameterManager:SubscribeParameter(spec_name, QS_DELTA_HEDGE_SPEC, false, "ParameterManager.lua" );
--the parameter type can be: QS_DELTA_HEDGE_SPEC=0; QS_SKEW_SPEC=1; QS_VOLATILITY_SPEC=2; QS_PRICING_SPEC=3; QS_HOLIDAY_SPEC=4; QS_DIVIDEND_SPEC=5; QS_UNDERLYING_SPEC=6; QS_VOLPATH_SPEC=7; QS_INTERESTRATE_SPEC=8
--ParameterManager:SubscribeParameter(spec_name, QS_DELTA_HEDGE_SPEC, true, "stateless.lua" );

	local GetDeltaHedgeObject_1 = ParameterManager:GetDeltaHedgeSpec(spec_name)
	local D_Products_Table = GetDeltaHedgeObject_1[1]:Products()
	
	if D_Products_Table ~= nil then 
		for k, v in pai(D_Products_Table) do
			print("D_Products_Table returns"..tostring(k).."="..v);
		end
	else
		print("The spec_name is nil")
	end
	
	GetDeltaHedgeObject_1[1]:ClearProducts()
			
	GetDeltaHedgeObject_1[1]:AddProduct("SIM.O.XJO.>")
	
--	local Add_D_Products = ParameterManager:SetDeltaHedgeSpec(GetDeltaHedgeObject_1[1])

	GetDeltaHedgeObject_1[1]:SetKey("SIMSPECtest")
	
	ParameterManager:SubscribeParameter("SIMSPECtest", QS_DELTA_HEDGE_SPEC, false, "ParameterManager.lua" );
	
	ParameterManager:SetDeltaHedgeSpec(GetDeltaHedgeObject_1[1])


------------ test skew series ---------------------------------------

	ParameterManager:SubscribeParameter("Ready", QS_SKEW_SPEC, false, "ParameterManager.lua" );

	local GetSkewSpecObject_1 = ParameterManager:GetSkewSpec("Ready")
	
	if GetSkewSpecObject_1 == nil then print("FAIL to get skew spec"); end
		
	local S_Products_Table = GetSkewSpecObject_1[1]:GetSkewSeries()
	
	if S_Products_Table ~= nil then 
		for k, v in pai(S_Products_Table) do
			print("S_Products_Table returns"..tostring(k).."="..tostring(v));
		end
	else
		print("The Skew_Spec is nil")
	end
	
		
	local newSkewSeries_1 = SkewSeries:CreateInstance()
	newSkewSeries_1:SetExpireDate(Date:FromString("20131010"));
	newSkewSeries_1:SetExpireLabel("10 Oct 13");
	
--[[	
	local newSkewStrike_1 = Skew:CreateInstance()
	newSkewStrike_1:SetStrike(-50)
	newSkewStrike_1:SetStrike(200)
	local insert_new_skew_strike = QuantENGINESkewSeries[1]:InsertSkew(newSkewStrike_1)	
]]--	
	local insert_new_skew = GetSkewSpecObject_1[1]:InsertSkewSeries(newSkewSeries_1)
	ParameterManager:SubscribeParameter("Ready", QS_SKEW_SPEC, false, "ParameterManager.lua" );
	ParameterManager:SetSkewSpec(GetSkewSpecObject_1[1])
	
	if insert_new_skew == true then
		print("insert the new skew series success!~!")
	end
		
------------ test VolatilitySpec -------------------------------------


	ParameterManager:SubscribeParameter("VOLSPEC_TEST", QS_VOLATILITY_SPEC, false, "ParameterManager.lua" ); 

	local GetVolatilitySpec_1 = ParameterManager:GetVolatilitySpec("VOLSPEC_TEST")

	if GetVolatilitySpec_1 == nil then print("FAIL to get the volatility spec"); end
	
	local Volatility_Series_Table = GetVolatilitySpec_1[1]:GetVolSeries()
	
	if Volatility_Series_Table ~= nil then 
		for k, v in pai(Volatility_Series_Table) do
			print("Volatility_Series_Table returns"..tostring(k).."="..tostring(v));
		end
	else
		print("The VOLSPEC_TEST is nil")
	end
	
	
	local newVol_1 = Volatility:CreateInstance()
	newVol_1:SetStrike(200)
	newVol_1:SetVolatility(2)
	
	
	local newVolSeries_1 = VolatilitySeries:CreateInstance()
	newVolSeries_1:SetExpireDate(Date:FromString("20131010"));
	newVolSeries_1:SetExpireLabel("10 Oct 13");
	local InsertNewVolSeries = newVolSeries_1:InsertVolatility(newVol_1);
	
	
	local insert_new_Vol = GetVolatilitySpec_1[1]:InsertVolSeries(newVolSeries_1)
	ParameterManager:SubscribeParameter("VOLSPEC_TEST", QS_VOLATILITY_SPEC, false, "ParameterManager.lua");
	ParameterManager:SetVolatilitySpec(GetVolatilitySpec_1[1])
	
	if insert_new_Vol == true then
		print("insert the new skew series success!~!")
	end
	
	
-------------test VolPathSpec ------------------------

		
	ParameterManager:SubscribeParameter("Flat", QS_VOLPATH_SPEC, false, "ParameterManager.lua" ); 

	local GetVolPathSpec_1 = ParameterManager:GetVolPathSpec("Flat")

	if GetVolPathSpec_1 == nil then print("FAIL to get the volPath spec"); end
	
	local VolPath_Series_Table = GetVolPathSpec_1[1]:GetVolSeries()
	
	if VolPath_Series_Table ~= nil then 
		for k, v in pai(VolPath_Series_Table) do
			print("VolPath_Series_Table returns"..tostring(k).."="..tostring(v));
		end
	else
		print("The Flat is nil")
	end
	
	
	local newVolPath_1 = VolPath:CreateInstance()
	newVolPath_1:SetForwardPrice(2000)
	newVolPath_1:SetVol(3)
	
	
	local newVolPathSeries_1 = VolPathSeries:CreateInstance()
	newVolPathSeries_1:SetExpireDate(Date:FromString("20131010"));
	newVolPathSeries_1:SetExpiryLabel("10 Oct 13");
	newVolPathSeries_1:SetReferencePrice(105)
	local InsertNewVolPathSeries = newVolPathSeries_1:InsertPath(newVolPath_1);
	
	
	local insert_new_VolPath = GetVolPathSpec_1[1]:InsertVolSeries(newVolPathSeries_1)
	ParameterManager:SubscribeParameter("Flat", QS_VOLPATH_SPEC, false, "ParameterManager.lua");
	ParameterManager:SetVolPathSpec(GetVolPathSpec_1[1])
	
	if insert_new_VolPath == true then
		print("insert the new volpath series success!~!")
	end
	
	
------------------- Test the InterestRateSpec -------------------------	

	ParameterManager:SubscribeParameter("AU_INT_ZHENG", QS_INTERESTRATE_SPEC, false, "ParameterManager.lua" ); 

	local GetInterestRateSpec_1 = ParameterManager:GetInterestRateSpec("AU_INT_ZHENG")

	if GetInterestRateSpec_1 == nil then print("FAIL to get the InterestRate spec"); end
	
	local InterestRate_Series_Table = GetInterestRateSpec_1[1]:GetRateSeries()
	
	if InterestRate_Series_Table ~= nil then 
		for k, v in pai(InterestRate_Series_Table) do
			print("InterestRate_Series_Table returns"..tostring(k).."="..tostring(v));
		end
	else
		print("The AU_INT_ZHENG is nil")
	end
	
	
	local newRateCurrency_1 = InterestRate:CreateInstance()
	newRateCurrency_1:SetRate(100)
	newRateCurrency_1:SetLength(0.1)	
	
	
	
	local newRateSeries_1 = InterestRateSeries:CreateInstance()
	newRateSeries_1:SetCurrency("HKD");
	
	local InsertNewRateSeries = newRateSeries_1:InsertRate(newRateCurrency_1);
	
	
	local insert_new_InterestRate = GetInterestRateSpec_1[1]:InsertRateSeries(newRateSeries_1)
	ParameterManager:SubscribeParameter("AU_INT_ZHENG", QS_INTERESTRATE_SPEC, false, "ParameterManager.lua" );
	ParameterManager: SetInterestRateSpec(GetInterestRateSpec_1[1])
	
	if insert_new_InterestRate == true then
		print("insert the new InterestRate series success!~!")
	end



--------------- test PricingSpec ---------------------------------------

	
	ParameterManager:SubscribeParameter("TEST", QS_PRICING_SPEC, false, "ParameterManager.lua" ); 

	
	local GetPricingSpec_1 = ParameterManager:GetPricingSpec("TEST")

	if GetPricingSpec_1 == nil then print("FAIL to get the pricing spec"); end
	
	local Pricing_Spec_Key = GetPricingSpec_1[1]:GetKey()
	print("GetPricingSpec_1[1]:GetKey()="..tostring(Pricing_Spec_Key))
	
	local Pricing_Spec_VolSpec = GetPricingSpec_1[1]:GetVolatilitySpec()
	print("GetPricingSpec_1[1]:GetVolatilitySpec()="..tostring(Pricing_Spec_VolSpec))
	
	
	local Pricing_Spec_VolModelGenericSpec = GetPricingSpec_1[1]:GetVolModelGenericSpec()
	print("GetPricingSpec_1[1]:GetVolModelGenericSpec()="..tostring(Pricing_Spec_VolModelGenericSpec))
	
	local Pricing_Spec_InterestRate = GetPricingSpec_1[1]:GetInterestRateSpec()
	print("GetPricingSpec_1[1]:GetInterestRateSpec()="..tostring(Pricing_Spec_InterestRate))
	
	local Pricing_Spec_Skew = GetPricingSpec_1[1]:GetSkewSpec()
	print("GetPricingSpec_1[1]:GetSkewSpec()="..tostring(Pricing_Spec_Skew))
	
	local Pricing_Spec_VolPathSpec = GetPricingSpec_1[1]:GetVolPathSpec()
	print("GetPricingSpec_1[1]:GetVolPathSpec()="..tostring(Pricing_Spec_VolPathSpec))
	
	local Pricing_Spec_Cost = GetPricingSpec_1[1]:GetCostOfCarrySpec()
	print("GetPricingSpec_1[1]:GetCostOfCarrySpec()="..tostring(Pricing_Spec_Cost))
	
	local Pricing_Spec_Underlying = GetPricingSpec_1[1]:GetUnderlyingSpec()
	print("GetPricingSpec_1[1]:GetUnderlyingSpec()="..tostring(Pricing_Spec_Underlying))
	
	local Pricing_Spec_Dividend = GetPricingSpec_1[1]:GetDividendSpec()
	print("GetPricingSpec_1[1]:GetDividendSpec()="..tostring(Pricing_Spec_Dividend))
	
	local Pricing_Spec_Currency = GetPricingSpec_1[1]:GetCurrencySpec()
	print("GetPricingSpec_1[1]:GetCurrencySpec()="..tostring(Pricing_Spec_Currency))
	
	local Pricing_Spec_Holiday = GetPricingSpec_1[1]:GetHolidaySpec()
	print("GetPricingSpec_1[1]:GetHolidaySpec()="..tostring(Pricing_Spec_Holiday))
	
	local Pricing_Spec_SettleSpec = GetPricingSpec_1[1]:GetSettlementSpec()
	print("GetPricingSpec_1[1]:GetSettlementSpec()="..tostring(Pricing_Spec_SettleSpec))
	
	
	local Pricing_Spec_DeltaHedgeSpec = GetPricingSpec_1[1]:GetDeltaHedgeSpec()
	print("GetPricingSpec_1[1]:GetDeltaHedgeSpec()="..tostring(Pricing_Spec_DeltaHedgeSpec))
	
	local Pricing_Spec_RootOptionID = GetPricingSpec_1[1]:GetRootOptionID()
	print("GetPricingSpec_1[1]:GetRootOptionID()="..tostring(Pricing_Spec_RootOptionID))
	
	local Pricing_Spec_Currency_1 = GetPricingSpec_1[1]:GetCurrency()
	print("GetPricingSpec_1[1]:GetCurrency()="..tostring(Pricing_Spec_Currency_1))
	
------------>
--[[	
	local Pricing_Spec_Set = PricingSpecification:CreateInstance()
	
	Pricing_Spec_Set:SetKey("QA_TEST_New")
	Pricing_Spec_Set:SetVolatilitySpec("SAP1")
	Pricing_Spec_Set:SetVolModelGenericSpec("")
	Pricing_Spec_Set:SetInterestRateSpec("AU_INT_ZHENG")
	Pricing_Spec_Set:SetSkewSpec("Ready")
	Pricing_Spec_Set:SetVolPathSpec("Flat")
	Pricing_Spec_Set:SetCostOfCarrySpec("AU_INT_ZHENG")
	Pricing_Spec_Set:SetUnderlyingSpec("PETER")
	Pricing_Spec_Set:SetDividendSpec("QA_QUANT")
	Pricing_Spec_Set:SetCurrencySpec("[SYSTEM]")
	Pricing_Spec_Set:SetHolidaySpec("TEST_HOLIDAYS")
	Pricing_Spec_Set:SetSettlementSpec("TEST_HOLIDAYS")
	Pricing_Spec_Set:SetDeltaHedgeSpec("SIMSPECtest")
	Pricing_Spec_Set:SetRootOptionID("SIM.O.XJO.>")
	Pricing_Spec_Set:SetCurrency("HKD")
	
	ParameterManager:SubscribeParameter("QA_TEST_New", QS_PRICING_SPEC, false, "ParameterManager.lua" )
	ParameterManager:SetPricingSpec(Pricing_Spec_Set)
]]--

	GetPricingSpec_1[1]:SetKey("TEST")
	GetPricingSpec_1[1]:SetVolatilitySpec("SAP1")
	GetPricingSpec_1[1]:SetVolModelGenericSpec("")
	GetPricingSpec_1[1]:SetInterestRateSpec("AU_INT_ZHENG")
	GetPricingSpec_1[1]:SetSkewSpec("Ready")
	GetPricingSpec_1[1]:SetVolPathSpec("Flat")
	GetPricingSpec_1[1]:SetCostOfCarrySpec("AU_INT_ZHENG")
	GetPricingSpec_1[1]:SetUnderlyingSpec("PETER")
	GetPricingSpec_1[1]:SetDividendSpec("QA_QUANT")
	GetPricingSpec_1[1]:SetCurrencySpec("[SYSTEM]")
	GetPricingSpec_1[1]:SetHolidaySpec("TEST_HOLIDAYS")
	GetPricingSpec_1[1]:SetSettlementSpec("TEST_HOLIDAYS")
	GetPricingSpec_1[1]:SetDeltaHedgeSpec("SIMSPECtest")
	GetPricingSpec_1[1]:SetRootOptionID("SIM.O.XJO.>")
	GetPricingSpec_1[1]:SetCurrency("HKD")
	ParameterManager:SetPricingSpec(GetPricingSpec_1[1])
		
	
-----------test dividend spec -----------------------------	
	
	ParameterManager:SubscribeParameter("DIVX", QS_DIVIDEND_SPEC, false, "ParameterManager.lua" ); 

	local GetDividendSpec_1 = ParameterManager:GetDividendSpec("DIVX")

	if GetDividendSpec_1 == nil then print("FAIL to get the Dividend spec"); end
	
	local Dividend_Products_Table = GetDividendSpec_1[1]:GetProducts()
	
	if Dividend_Products_Table ~= nil then 
		for k, v in pai(Dividend_Products_Table) do
			print("Dividend_Products_Table returns"..tostring(k).."="..tostring(v));
		end
	else
		print("The DIVX is nil")
	end
	
	
	local newDividend_1 = Dividend:CreateInstance()
	newDividend_1:SetDate(Date:FromString("20131213"))
	newDividend_1:SetAmount(888)
	
	
	local newProductDividend_1 = ProductDividend:CreateInstance()
	newProductDividend_1:SetProduct("SIM.F.XJO.DEC2013");
	local InsertnewProductDividend = newProductDividend_1:InsertDividend(newDividend_1);
	
	
	local insert_new_Dividend = GetDividendSpec_1[1]:InsertProductDividend(newProductDividend_1)
	ParameterManager:SubscribeParameter("DIVX", QS_DIVIDEND_SPEC, false, "ParameterManager.lua");
	ParameterManager:SetDividendSpec(GetDividendSpec_1[1])
	
	if insert_new_Dividend == true then
		print("insert the new dividend products success!~!")
	end


-------------test underlying spec -----------------------------

	ParameterManager:SubscribeParameter("PETER", QS_UNDERLYING_SPEC, false, "ParameterManager.lua" ); 

	local GetUnderlyingSpec_1 = ParameterManager:GetUnderlyingSpec("PETER")

	if GetUnderlyingSpec_1 == nil then print("FAIL to get the Underlying spec"); end
	
--[[	local UnderlyingSpec_Expires_Table = GetUnderlyingSpec_1[1]:GetUnderlyingExpires()
	
	if UnderlyingSpec_Expires_Table ~= nil then 
		for k, v in pai(UnderlyingSpec_Expires_Table) do
			print("UnderlyingSpec_Expires_Table returns"..tostring(k).."="..tostring(v));
		end
	else
		print("The PETER is nil")
	end
]]--
	
	local PricingRule_Table = GetUnderlyingSpec_1[1]:GetPricingRule()
	
	if PricingRule_Table ~= nil then 
		for k, v in pai(PricingRule_Table) do
			print("PricingRule_Table returns"..tostring(k).."="..tostring(v));
		end
	else
		print("The PETER'S Pricing Rule is nil")
	end
	
	print("GetUnderlyingSpec_1[1]:GetRootUnderlying()="..tostring(GetUnderlyingSpec_1[1]:GetRootUnderlying()))
	print("GetUnderlyingSpec_1[1]:GetRootDeltaScaling()="..tostring(GetUnderlyingSpec_1[1]:GetRootDeltaScaling()))
--	print("GetUnderlyingSpec_1[1]:GetFrontMonthUnderlying()="..tostring(GetUnderlyingSpec_1[1]:GetFrontMonthUnderlying()))
	print("GetUnderlyingSpec_1[1]:GetPricingRule()="..tostring(GetUnderlyingSpec_1[1]:GetPricingRule()))
	print("GetUnderlyingSpec_1[1]:GetCalculationMethod()="..tostring(GetUnderlyingSpec_1[1]:GetCalculationMethod()))
	
	GetUnderlyingSpec_1[1]:SetRootUnderlying("SIM.F.XJO.DEC2013")
	GetUnderlyingSpec_1[1]:SetRootDeltaScaling("SIM.F.XJO.SEP2013")
	GetUnderlyingSpec_1[1]:SetFrontMonthUnderlying("SIM.F.XJO.AUG2013")
--	GetUnderlyingSpec_1[1]:SetPricingRule()
	GetUnderlyingSpec_1[1]:SetCalculationMethod(1)
	
end

function OnStop()
	print("Begin the stop running the parameter prj.")
	ParameterManager:UnsubscribeParameter(spec_name, QS_DELTA_HEDGE_SPEC, false, "ParameterManager.lua" );
end