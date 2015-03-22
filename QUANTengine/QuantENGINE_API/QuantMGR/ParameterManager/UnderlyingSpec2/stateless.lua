local QuantCORE = QuantCORE();
local ParameterManager = QuantCORE:ParameterManager();

function OnParameterNotify( key, paramType )
    print("OnParameterNotify()");
    print("Key="..key);
    print("Parameter type="..ParameterTypeToString(paramType));

    -- Get table of UnderlyingSpecification for key
    local specs = ParameterManager:GetUnderlyingSpec(key);
    -- Get a table of UnderlyingSpecification defined in spec
    if specs == nil then
        print("No UnderlyingSpecification found in parameter manager for key="..key);
    else
        print("The UnderlyingSpecification number ="..#specs);
        -- Print details in each UnderlyingSpecification
        local specIndex = 1;
        while (specIndex <= #specs) do 
            local underSpec = specs[specIndex];
            
      		for k,v in pai(specs) do
      			print("k = "..tostring(k))
      			print("v = "..tostring(v))
      		end
      			      			
            print("specs ="..tostring(specs[1]))
            print("Key of spec "..specIndex.."="..underSpec:GetKey());
            print("Root underlying = "..underSpec:GetRootUnderlying());
            print("Root delta scaling = "..underSpec:GetRootDeltaScaling());
            print("Front month underlying = "..underSpec:GetFrontMonthUnderlying());
            
            --print("Pricing rule = "..underSpec:GetPricingRule());
            local getRules = underSpec:GetPricingRule();

    		if getRules == nil then
        		print("Failed to get pricing rules");
    		else
        		print("Pricing rules number is: "..#getRules);
        		print("Display pricing rule's order......");
        		local key = 1;
        		while(key <= #getRules) do
            		print(PricingRuleToString(getRules[key]));
            		key = key + 1;
        		end
    		end
            
            local underExpiries = underSpec:GetUnderlyingExpiries();
            if underExpiries == nil then
                print("No underlying expiries get from UnderlyingSpecification");
            else
                print("Underlying expiries number in spec="..#underExpiries);
                local index = 1;
                while ( index <= #underExpiries ) do
                    local underExpiry = underExpiries[index];
                    print("Outright ID = "..underExpiry:GetOutright());
                    print("Underlying ID = "..underExpiry:GetUnderlying());
                    print("Price offset  = "..underExpiry:GetPriceOffset());
                    index = index + 1;
                end
            end
            specIndex = specIndex + 1;
        end
    end
end