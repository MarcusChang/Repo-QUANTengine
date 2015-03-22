local QuantCORE = QuantCORE();
local ParameterManager = QuantCORE:ParameterManager();
local spec_name = "SKEWSPEC_TEST"

function OnStart()
    print("OnStart -- Subcribe parameter");
    ParameterManager:SubscribeParameter(spec_name, QS_SKEW_SPEC, false, "SkewSpecTest.lua" );
--    Timer(1, 5000, "");
end
--[[
function OnTimer(id)
    print("OnTimer -- Unsubscribe parameter");
    ParameterManager:UnsubscribeParameter(spec_name, QS_SKEW_SPEC, false, "" );
    SendCompletionCode(0, "Complete");
end
--]]
function OnStop()
	ParameterManager:UnsubscribeParameter(spec_name, QS_SKEW_SPEC, false, "SkewSpecTest.lua" );
end

function OnSkewSpec1(spec) 
    print("OnSkewSpec");
    --print key in spec
    print("key="..spec:GetKey());
    
    --find skew series in spec
    local skewSeries = spec:GetSkewSeries() 
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
    

-- this is  for testing RemoveSkewSeries()    
function OnSkewSpec2(spec) 
    print("OnSkewSpec"); 
    local skewSeries = spec:FindSkewSeries(Date:FromString("20051208")) 
    flag = spec: RemoveSkewSeries(Date:FromString("20051208"))
    print("flag value is "..tostring(flag))  
    ParameterManager:SetSkewSpec(spec)
    
end  

-- the folllowing is for ClearAllSkews() method

function OnSkewSpec3(spec) 
    print("OnSkewSpec");
    local skewSeries = spec:FindSkewSeries(Date:FromString("20060112")) 
     --print("Expire date="..skewSeries:GetExpireDate():AsString());
     --print("Expire label="..skewSeries:GetExpireLabel());
    
    spec:ClearAllSkews();
    ParameterManager:SetSkewSpec(spec);
     
end 


-- the following is to ClearAllSkews() in SkewSeries

function OnSkewSpec(spec) 
    print("OnSkewSpec");
    local skewSeries = spec:FindSkewSeries(Date:FromString("20130410")) 
    	if skewSeries== nil then 
    		print("there is no skew series got")
    	else
    		print("Skew find!");
    	end 
     print("Expire date="..skewSeries:GetExpireDate():AsString());
     print("Expire label="..skewSeries:GetExpireLabel());
     flag1 = skewSeries:RemoveSkew(0.01);
     spec:InsertSkewSeries(skewSeries); 
     --flag2 = skewSeries:RemoveSkew(0.01);
     print("flag value is"..tostring(flag1));
     --print("flag value is"..tostring(flag2));
   	 -- skewSeries:ClearAllSkews(1);
     ParameterManager:SetSkewSpec(spec);
     
end