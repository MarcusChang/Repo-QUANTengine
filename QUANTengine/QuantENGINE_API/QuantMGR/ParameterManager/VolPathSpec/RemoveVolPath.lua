local QuantCORE = QuantCORE();
local ParameterManager = QuantCORE:ParameterManager();
local spec_name = "KOSPITEST_MAC1";
local testFlag = false;
fittime = true

function OnStart()
    print("OnStart -- Subcribe parameter");
    ParameterManager:SubscribeParameter(spec_name, QS_VOLPATH_SPEC, false, "RemoveVolPath.lua" );
    --ParameterManager:SubscribeParameter(spec_name, QS_VOLPATH_SPEC, true, "stateless.lua" );
    print("Start 5 seconds timer")
    Timer(1, 5000, "");
end

function OnTimer(id)
    print("OnTimer -- Unsubscribe parameter");
    ParameterManager:UnsubscribeParameter(spec_name, QS_VOLPATH_SPEC, false, "RemoveVolPath.lua" );
    --ParameterManager:UnsubscribeParameter(spec_name, QS_VOLPATH_SPEC, true, "stateless.lua" );
    SendCompletionCode(0, "Complete");
end

function OnStop()

end

function OnVolPathSpec(spec) 
    print("OnVolaPathSpec");
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
        local date=Date:FromString("20130620")
        print(date:AsString());
        if fittime == true then
        spec:RemoveVolSeries(date)
        ParameterManager:SetVolPathSpec(spec);
        print ("20130620")
        fittime = false
    end
end
end