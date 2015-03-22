local QuantCORE = QuantCORE();
local ParameterManager = QuantCORE:ParameterManager();
--changeSpec = true;

function OnPricingSpec(pricingSpec) 
    print("OnPricingSpec GetKey="..pricingSpec:GetKey());
    print("VolatilitySpec="..pricingSpec:GetVolatilitySpec());
    print("VolModelGenericSpec="..pricingSpec:GetVolModelGenericSpec());
    print("InterestRateSpec="..pricingSpec:GetInterestRateSpec());
    print("SkewSpec="..pricingSpec:GetSkewSpec());
    print("VolPathSpec="..pricingSpec:GetVolPathSpec());
    print("CostOfCarrySpec="..pricingSpec:GetCostOfCarrySpec());
    print("UnderlyingSpec="..pricingSpec:GetUnderlyingSpec());
	print("DividendSpec="..pricingSpec:GetDividendSpec());
    print("CurrencySpec="..pricingSpec:GetCurrencySpec());
    print("HolidaySpec="..pricingSpec:GetHolidaySpec());
    print("SettlementSpec="..pricingSpec:GetSettlementSpec());
    print("DeltaHedgeSpec="..pricingSpec:GetDeltaHedgeSpec());
    print("RootOptionID="..pricingSpec:GetRootOptionID());
    print("Currency="..pricingSpec:GetCurrency());
    print("EuropeanPriceAlgorithm="..PriceAlgorithmToString(pricingSpec:GetEuropeanPriceAlgorithm()));
    print("AmericanPriceAlgorithm="..PriceAlgorithmToString(pricingSpec:GetAmericanPriceAlgorithm()));
    print("EuropeanVolatilityAlgorithm="..PriceAlgorithmToString(pricingSpec:GetEuropeanVolatilityAlgorithm()));
    print("GetAmericanVolatilityAlgorithm="..PriceAlgorithmToString(pricingSpec:GetAmericanVolatilityAlgorithm()));
    
   	print("------------->begin to test the void functions---------------->")
   	
   	
   	pricingSpec:SetKey("Marcus_NewKey");
    pricingSpec:SetVolatilitySpec("Marcus_NewVolatilitySpec");
    pricingSpec:SetVolModelGenericSpec("Marcus_NewVolModelGenSpec");
    pricingSpec:SetInterestRateSpec("Marcus_NewInterestRateSpec");
    pricingSpec:SetSkewSpec("Marcus_NewSkewSpec");
    pricingSpec:SetVolPathSpec("Marcus_NewVolPathSpec");
    pricingSpec:SetCostOfCarrySpec("Marcus_NewCostOfCarrySpec");
    pricingSpec:SetUnderlyingSpec("Marcus_NewUnderlyingSpec");
	pricingSpec:SetDividendSpec("Marcus_NewDividendSpec");
    pricingSpec:SetCurrencySpec("Marcus_NewCurrencySpec");
    pricingSpec:SetHolidaySpec("Marcus_NewHolidaySpec");
    pricingSpec:SetSettlementSpec("Marcus_NewSettlementSpec");
    pricingSpec:SetDeltaHedgeSpec("Marcus_NewDeltaHedgeSpec");
    pricingSpec:SetRootOptionID("Marcus_NewRootOptionID");
    pricingSpec:SetCurrency("Marcus_NewCurrency");
    pricingSpec:SetEuropeanPriceAlgorithm("Marcus_NewEuroPriceAlg");
    pricingSpec:SetAmericanPriceAlgorithm("Marcus_NewAmerPriceAlg");
    pricingSpec:SetEuropeanVolatilityAlgorithm("Marcus_NewEuroVolAlg");
    pricingSpec:SetAmericanVolatilityAlgorithm("Marcus_NewAmerVolAlg");
   	
	print("-----------> begin to get the new set OnPricingSpec-------------->")
 	
   	print("SetOnPricingSpec SetKey="..pricingSpec:GetKey());
    print("SetVolatilitySpec="..pricingSpec:GetVolatilitySpec());
    print("SetVolModelGenericSpec="..pricingSpec:GetVolModelGenericSpec());
    print("SetInterestRateSpec="..pricingSpec:GetInterestRateSpec());
    print("SetSkewSpec="..pricingSpec:GetSkewSpec());
    print("SetVolPathSpec="..pricingSpec:GetVolPathSpec());
    print("SetCostOfCarrySpec="..pricingSpec:GetCostOfCarrySpec());
    print("SetUnderlyingSpec="..pricingSpec:GetUnderlyingSpec());
	print("SetDividendSpec="..pricingSpec:GetDividendSpec());
    print("SetCurrencySpec="..pricingSpec:GetCurrencySpec());
    print("SetHolidaySpec="..pricingSpec:GetHolidaySpec());
    print("SetSettlementSpec="..pricingSpec:GetSettlementSpec());
    print("SetDeltaHedgeSpec="..pricingSpec:GetDeltaHedgeSpec());
    print("SetRootOptionID="..pricingSpec:GetRootOptionID());
    print("SetCurrency="..pricingSpec:GetCurrency());
    print("SetEuropeanPriceAlgorithm="..PriceAlgorithmToString(pricingSpec:GetEuropeanPriceAlgorithm()));
    print("SetAmericanPriceAlgorithm="..PriceAlgorithmToString(pricingSpec:GetAmericanPriceAlgorithm()));
    print("SetEuropeanVolatilityAlgorithm="..PriceAlgorithmToString(pricingSpec:GetEuropeanVolatilityAlgorithm()));
    print("SetAmericanVolatilityAlgorithm="..PriceAlgorithmToString(pricingSpec:GetAmericanVolatilityAlgorithm()));
end 


