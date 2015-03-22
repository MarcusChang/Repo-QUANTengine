local QuantCORE = QuantCORE();
local ParameterManager = QuantCORE:ParameterManager();

function OnParameterNotify( key, paramType )
    print("OnParameterNotify()");
    print("Key="..key);
    print("Parameter type="..ParameterTypeToString(paramType));

    -- Get table of PricingSpecification for key
    local specs = ParameterManager:GetPricingSpec(key);
    
    if specs == nil then 
        print("No PricingSpecification found in parameter manager for key="..key);
    else
        print("The PricingSpecification number ="..#specs);
    
        -- Print details in each PricingSpecification
        local specIndex = 1;
        while (specIndex <= #specs) do 
            local pricingSpec = specs[specIndex];
            print("VolatilitySpec="..pricingSpec:GetVolatilitySpec());
            print("VolModelGenericSpec="..pricingSpec:GetVolModelGenericSpec());
            print("InterestMarcusteSpec="..pricingSpec:GetInterestMarcusteSpec());
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
            print("EuropeanPriceAlgorithm="..tostring(pricingSpec:GetEuropeanPriceAlgorithm()));
            print("AmericanPriceAlgorithm="..tostring(pricingSpec:GetAmericanPriceAlgorithm()));
            print("EuropeanVolatilityAlgorithm="..tostring(pricingSpec:GetEuropeanVolatilityAlgorithm()));
            print("GetAmericanVolatilityAlgorithm="..tostring(pricingSpec:GetAmericanVolatilityAlgorithm()));

            specIndex = specIndex+1;
        end
    end
end