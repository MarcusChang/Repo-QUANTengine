local QuantCORE = QuantCORE();
local ParameterManager = QuantCORE:ParameterManager();

function OnParameterNotify( key, paramType )
    print("OnParameterNotify()");
    print("Key="..key);
    print("Parameter type="..ParameterTypeToString(paramType));

    -- Get table of VolPathSpecification for key
    local specs = ParameterManager:GetVolPathSpec(key);
    
    if specs == nil then 
        print("No VolPathSpecification found in parameter manager for key="..key);
    else
        print("The VolPathSpecification number ="..#specs);
    
        -- Print details in each VolPathSpecification
        local specIndex = 1;
        while (specIndex <= #specs) do 
            local volPathSpec = specs[specIndex];
            print("Key of spec"..specIndex.."="..volPathSpec:GetKey());
            -- Get a table of volatility path series defined in spec
    		local volPathSeriesTable = volPathSpec:GetVolSeries();
    		if volPathSeriesTable == nil then
        		print("No Volatility path series get from VolPathSpecification");
    		else
        		print("Volatility path series number in spec="..#volPathSeriesTable);
        		local index = 1;
        		while ( index <= #volPathSeriesTable ) do
            		local volPathSeries = volPathSeriesTable[index];
            		
            		print("Expire date="..volPathSeries:GetExpireDate():AsString());
            		print("Expire label="..volPathSeries:GetExpiryLabel());
            		
            		local volPathTable = volPathSeries:GetVolPaths();
            		print("Volatility Path number: "..#volPathTable);
            		local i = 1;
            		while (i <= #volPathTable)do
                		local volPath = volPathTable[i];
                		print("Forward price: "..tostring(volPath:GetForwardPrice()));
                		print("Volatility: "..tostring(volPath:GetVol()));
                		i = i + 1;
            		end
            		index = index + 1;
        		end
    		end
            specIndex = specIndex+1
        end
    end
end