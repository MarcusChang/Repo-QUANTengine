local QuantCORE = QuantCORE();
local ParameterManager = QuantCORE:ParameterManager();

function OnParameterNotify( key, paramType )
    print("OnParameterNotify()");
    print("Key="..key);
    print("Parameter type="..ParameterTypeToString(paramType));

    -- Get table of rsVolPathSpecification for key
    local specs = ParameterManager:GetInterestRateSpec(key);
    
    if specs == nil then 
        print("No rsGetInterestRateSpec found in parameter manager for key="..key);
    else
        print("The rsGetInterestRateSpec number ="..#specs);
    
        -- Print details in each rsVolPathSpecification
        local specIndex = 1;
        while (specIndex <= #specs) do 
            local InterestRateSpec = specs[specIndex];
            print("Key of spec"..specIndex.."="..InterestRateSpec:GetKey());
            -- Get a table of InterestRateSpec series defined in spec
    		local InterestRateSpecTable = InterestRateSpec:GetRateSeries();
    		if InterestRateSpecTable == nil then
        		print("No Volatility path series get from rsInterestRateSpecification");
    		else
        		print("Interest Rate series number in spec="..#InterestRateSpecTable);
        		local index = 1;
        		while ( index <= #InterestRateSpecTable ) do
            		local InterestRateSeries = InterestRateSpecTable[index];
            		
            		
            		print("Currency="..InterestRateSeries:GetCurrency());
            
            		local rateTable = InterestRateSeries:GetRates();
            		print("Rate number: "..#rateTable);
            		local i = 1;
            		while (i <= #rateTable)do
                		local rate = rateTable[i];
                		print("Period: "..tostring(rate:GetLength()));
                		print("Rate: "..tostring(rate:GetRate()));
                		i = i + 1;
            		end
            		index = index + 1;
        
        		end
    		end
            specIndex = specIndex+1
        end
    end
end