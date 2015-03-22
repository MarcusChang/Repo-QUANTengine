local QuantCORE = QuantCORE();
local ParameterManager = QuantCORE:ParameterManager();
local spec_name = "SKEWSPEC_TEST"
local newKey = "SKEWSPEC_TEST_00"
local testFlag = false 

function OnStart()
    print("OnStart -- Subcribe parameter");
    ParameterManager:SubscribeParameter(spec_name, QS_SKEW_SPEC, false, "SkewSpecUpdate.lua" );
    --ParameterManager:SubscribeParameter(spec_name, QS_SKEW_SPEC, true, "stateless.lua" );
    Timer(1,  "SkewSpecUpdate.lua", true, "");
end

function OnStop()
	ParameterManager:UnsubscribeParameter(spec_name, QS_SKEW_SPEC, false, "SkewSpecUpdate.lua" );
    --ParameterManager:UnsubscribeParameter(spec_name, QS_SKEW_SPEC, true, "stateless.lua" );
    TestCreateInstance();
end

function OnTimer(id)
    print("OnTimer -- Unsubscribe parameter");
end


function TestCreateInstance()
	 if (testFlag) then 
	 	print("Tested!")
	 	return;
	 end 

     print("Begin to test newSpec")
    local newSpec = SkewSpecification:CreateInstance();
    newSpec:SetKey(newKey);
    
    local newSeries = SkewSeries:CreateInstance();
    newSeries:SetExpireLabel("27 Feb 12");
    
    local newSkew1 = Skew:CreateInstance();
    newSkew1:SetStrike(0.2);
    newSkew1:SetSkew(0.01);

    local newSkew2 = Skew:CreateInstance();
    newSkew2:SetStrike(0.4);
    newSkew2:SetSkew(0.02);
 
    local newSkew3 = Skew:CreateInstance();
    newSkew3:SetStrike(0.6);
    newSkew3:SetSkew(0.03);
           
    local result1 = newSeries:InsertSkew(newSkew1);
    local result2 = newSeries:InsertSkew(newSkew2);
    local result3 = newSeries:InsertSkew(newSkew3);
    
    print("insert skew1 result is: "..tostring(result1));
    print("insert skew2 result is: "..tostring(result2));
    print("insert skew3 result is: "..tostring(result3));
    
    local rt = newSpec:InsertSkewSeries(newSeries);
    print("Insert new series to spec result is: "..tostring(rt));
    
    print("Subscribe to the new spec")
    ParameterManager:SubscribeParameter(newKey,QS_SKEW_SPEC,false,"SkewSpecUpdate.lua" )
    
    print("ready to set new spec");
    ParameterManager:SetSkewSpec(newSpec); 
	 
end 
--[[
function OnSkewSpec(spec)
	print("New spec callback!Key is "..spec:GetKey());
	DisplaySpec(spec)
	ParameterManager:UnsubscribeParameter(newKey,QS_SKEW_SPEC,false,"SkewSpecUpdate.lua")
	SendCompletionCode(0,"Complete");
end 
--]]

function OnSkewSpec(spec)

	print("OnSkewSpec");
	print("key="..spec:GetKey());
	DisplaySpec(spec);
	
end 

function DisplaySpec(spec)
	print("Display spec content -----------")
	-- Get a table of SkewSeries defined in spec
    local skewSeries = spec:GetSkewSeries();
    if skewSeries == nil then
        print("No skew series get from SkewSpecification");
    else
        print("Skew series number in spec="..#skewSeries);
        local index = 1;
        while ( index <= #skewSeries ) do
            local skewSeries = skewSeries[index];
            
            print("Expire date="..skewSeries:GetExpireDate():AsString());
            print("Expire label="..skewSeries:GetExpireLabel());
            local skews = skewSeries:GetSkews();
                
            print("Skew number: "..#skews);
            local i = 1;
            while (i <= #skews)do
                local skew = skews[i];
        
                	print("Strike: "..tostring(skew:GetStrike()));
                	print("Skew: "..tostring(skew:GetSkew()));
                	i = i + 1;
                    end
            index = index + 1;
        end
    end
end 	

