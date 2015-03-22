local QuantCORE = QuantCORE();
local ParameterManager = QuantCORE:ParameterManager();
local spec_name = "VOLSPEC_TEST";
local newKey = "VOLSPEC_TEST_MAC1"
local testFlag = false;

function OnStart()
    print("OnStart -- Subcribe parameter");
    ParameterManager:SubscribeParameter(spec_name, QS_VOLATILITY_SPEC, false, "VolatilitySpec.lua" );
    --ParameterManager:SubscribeParameter(spec_name, QS_VOLATILITY_SPEC, true, "stateless.lua" );
    print("Start 5 seconds timer")
    TestCreateInstance();
--    Timer(1, 5000, "VolatilitySpec.lua");
end

--[[
function OnTimer(id)
    print("OnTimer -- Unsubscribe parameter");
    
end
--]]


function OnStop()
	ParameterManager:UnsubscribeParameter(spec_name, QS_VOLATILITY_SPEC, false, "VolatilitySpec.lua" );
    --ParameterManager:UnsubscribeParameter(spec_name, QS_VOLATILITY_SPEC, true, "stateless.lua" );
    --TestCreateInstance();

end

function TestCreateInstance()

	if (testFlag) then
		print("Tested!")
		return;
	end
	
	print("Begin to test new spec---------------------");
    local newSpec = VolatilitySpecification:CreateInstance();
    newSpec:SetKey(newKey);
    
    local ExDate = Date:FromString("20130620")
    local newSeries = VolatilitySeries:CreateInstance();
    newSeries:SetExpireLabel("20 Jun 13");
    newSeries:SetExpireDate(ExDate)
    		
    local newVo1 = Volatility:CreateInstance();
    newVo1:SetStrike(0.2);
    newVo1:SetVolatility(0.01);

    local newVo2 = Volatility:CreateInstance();
    newVo2:SetStrike(0.4);
    newVo2:SetVolatility(0.02);
 
    local newVo3 = Volatility:CreateInstance();
    newVo3:SetStrike(0.6);
    newVo3:SetVolatility(0.03);
           
    local result1 = newSeries:InsertVolatility(newVo1);
    local result2 = newSeries:InsertVolatility(newVo2);
    local result3 = newSeries:InsertVolatility(newVo3);
    
    print("insert volatiltiy 1 result is: "..tostring(result1));
    print("insert volatiltiy 2 result is: "..tostring(result2));
    print("insert volatiltiy 3 result is: "..tostring(result3));
    
    
    local FindVolatility = newSeries:FindVolatility(0.6);
    print("FindVolatility ="..tostring(FindVolatility));
    
    --newSeries:RemoveVolatility(0.6);
    
    local rt = newSpec:InsertVolSeries(newSeries);
    print("Insert new series to spec result is: "..tostring(rt));
    
    print("Subscribe to the new kew");        
    ParameterManager:SubscribeParameter(newKey, QS_VOLATILITY_SPEC, false, "VolatilitySpec.lua" );
    
    print("Begin to set new key"..newKey);
    ParameterManager:SetVolatilitySpec(newSpec);
    testFlag = true;
   	
   	
--  newSpec:RemoveVolSeries(Date:FromString("20130912"))
   
--  newSeries:RemoveVolatility(0.6);
--	newSpec:InsertVolSeries(newSeries);
--	ParameterManager:SetVolatilitySpec(newSpec);
    
    local volatility_table = newSeries:GetVolatilities();
    print("volatility_table ="..tostring(volatility_table));
    
    if (volatility_table == nil) then
    	print("the volatility_table = nil")
    end
    
    print("volatility_table size ="..tostring(#volatility_table))
     
    for k, v in pai(volatility_table) do
    	print("k = "..tostring(k));
    	print("v = "..tostring(v));
    end

--[[
 --REMOVE THE SERIES WITH THE DATE "20120913"
	local ExDate = Date:FromString("20130620")
	local newSeries = VolatilitySeries:CreateInstance();
	newSeries:SetExpireLabel("20 Jun 13");
	newSeries:SetExpireDate(ExDate)
	
	newSpec:RemoveVolSeries(ExDate)
	ParameterManager:SetVolatilitySpec(newSpec)
--]]
	
 --REMOVE ALL Volatilities     
    newSeries:ClearAllVolatilities()
    
    newSpec:InsertVolSeries(newSeries);
    
    ParameterManager:SetVolatilitySpec(newSpec);
    
    print ("-----------------------------------")   
   	
    

end


function OnVolatilitySpec(spec, fromSnapshot)
	if fromSnapshot == true then
		print("----------fromSnapshot = true--------")
	else
		print("----------fromSnapshot = false-------")
	end
	 
	print("New spec callback! Ky is: "..spec:GetKey());
	DisplaySpec(spec)
	--ParameterManager:UnsubscribeParameter(newKey, QS_VOLATILITY_SPEC, false, "VolatilitySpec.lua" );
	--SendCompletionCode(0, "Complete");
end


function DisplaySpec(spec)
	print("Display spec content--------------------------------------------------")
    -- Get a table of volatility series defined in spec
    local volSeriesTable = spec:GetVolSeries();
    if volSeriesTable == nil then
        print("No Volatility series get from VolatilitySpecification");
    else
        print("Volatility series number in spec="..#volSeriesTable);
        local index = 1;
        while ( index <= #volSeriesTable ) do
            local volSeries = volSeriesTable[index];
            print("Expire date="..volSeries:GetExpireDate():AsString());
            print("Expire label="..volSeries:GetExpireLabel());
            local volTable = volSeries:GetVolatilities();
            print("Volatility number: "..#volTable);
            local i = 1;
            while (i <= #volTable)do
                local vol = volTable[i];
                print("Strike: "..tostring(vol:GetStrike()));
                print("Volatility: "..tostring(vol:GetVolatility()));
                i = i + 1;
            end
            index = index + 1;
        end
    end

	

end 


