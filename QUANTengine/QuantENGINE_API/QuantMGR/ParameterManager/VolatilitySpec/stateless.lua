--require "VolatilitySpec"
local QuantCORE = QuantCORE();
local ParameterManager = QuantCORE:ParameterManager();

function OnParameterNotify( key, paramType, fromSnapshot )

	if fromSnapshot == true then
		print("----------fromSnapshot = true--------")
	else
		print("----------fromSnapshot = false-------")
	end
	
    print("OnParameterNotify()");
    print("Key="..key);
    print("Parameter type="..ParameterTypeToString(paramType));

    -- Get table of VolatilitySpecification for key
    local specs = ParameterManager:GetVolatilitySpec(key);
    
    if specs == nil then 
        print("No VolatilitySpecification found in parameter manager for key="..key);
    else
        print("The VolatilitySpecification number ="..#specs);
    
        -- Print details in each VolatilitySpecification
        local specIndex = 1;
        while (specIndex <= #specs) do 
            local volSpec = specs[specIndex];
            print("Key of spec"..specIndex.."="..volSpec:GetKey());
            local volSeriesTable = volSpec:GetVolSeries();
            
            if volSeriesTable == nil then
                print("No volatility series get from VolatilitySpecification");
                return;
            end

            print("volatility series number in spec"..specIndex.." = "..#volSeriesTable);
            -- Print all volatility series in each VolatilitySpecification
            local seriesIndex = 1;
            while (seriesIndex <= #volSeriesTable) do
                local volSeries = volSeriesTable[seriesIndex];
                if volSeries == nil then
                    print("No volatility series!");
                    return;
                end
                print("Expire date="..volSeries:GetExpireDate():AsString());
                print("Expire label="..volSeries:GetExpireLabel());
                local volTable = volSeries:GetVolatilities();
                
                if volTable == nil then
                    print("No volatilities get from VolatilitySeries");
                    return;
                end
                
                print("Volatilities numer = "..#volTable);
                local index = 1;
                while (index <= #volTable) do
                    local vol = volTable[index];
                    print("Strike: "..tostring(vol:GetStrike()));
                    print("Volatility: "..tostring(vol:GetVolatility()));
                    index = index+1
                end
                seriesIndex = seriesIndex + 1;
            end
            specIndex = specIndex+1
        end
    end
end