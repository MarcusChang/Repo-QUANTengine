require "VolPathSpec"
--changeSpec = true;

local reactor = QuantCORE();
local ParameterManager = reactor:ParameterManager();
local newKey = "KOSPITEST_MAC1";

function OnVolPathSpec(spec) 
    print("OnVolaPathSpec");
    --print key in spec
    print("key="..spec:GetKey());

--	DisplaySpec(spec);
    
    --spec:ClearAllPaths();
    
    TestCreateInstance();
    
end


function TestCreateInstance()

	if (testFlag) then
		print("Tested!")
		return;
	end
	
	print("Begin to test new spec---------------------");
    
	--local newSpec = ParameterManager:GetVolPathSpec(newKeys); 
	--local newSpecIndex = 1;
	
	--while (newSpecIndex <= #newSpec) do
	--local newvolPathSpec = newSpec[newSpecIndex];
         
    --print("newvolPathSpec="..newvolPathSpec);
         
   -- print("Key of newSpec"..newSpecIndex.."="..newvolPathSpec:GetKey());
    
    --end
         
    
    --local newSpec = VolPathSpecification():CreateInstance();
    --newSpec = SetKey(newKey);
    
    local newSpec = VolPathSpecification:CreateInstance();
    newSpec:SetKey(newKey);
    
    local ExDate = Date:FromString("20130620")
    local newSeries = VolPathSeries:CreateInstance();
    newSeries:SetExpiryLabel("20 Jun 13");
    newSeries:SetExpireDate(ExDate)
    
    local newVoPath1 = VolPath:CreateInstance();
    newVoPath1:SetForwardPrice(750);
    newVoPath1:SetVol(0.8885);

    local newVoPath2 = VolPath:CreateInstance();
    newVoPath2:SetForwardPrice(800);
    newVoPath2:SetVol(0.8886);
 
    local newVoPath3 = VolPath:CreateInstance();
    newVoPath3:SetForwardPrice(1000);
    newVoPath3:SetVol(0.8887);
           
    local result1 = newSeries:InsertPath(newVoPath1);
    local result2 = newSeries:InsertPath(newVoPath2);
    local result3 = newSeries:InsertPath(newVoPath3);
    
    print("insert Path 1 result is: "..tostring(result1));
    print("insert Path 2 result is: "..tostring(result2));
    print("insert Path 3 result is: "..tostring(result3));

    
    local rt = newSpec:InsertVolSeries(newSeries);
    print("Insert new series to spec result is: "..tostring(rt));
    
    print("Subscribe to the new kew");
    ParameterManager:SubscribeParameter(newKey, QS_VOLPATH_SPEC, false, "stateful.lua" );
    
    print("Begin to set new key"..newKey);
    ParameterManager:SetVolPathSpec(newSpec);
    testFlag = true;
    
    local volPath_table = newSeries:GetVolPaths();
    print("volPath_table ="..tostring(volPath_table));
    
    if (volPath_table == nil) then
    	print("the volPath_table = nil")
    end
    
    print("volPath_table size ="..tostring(#volPath_table))
     
    for k, v in pai(volPath_table) do
    	print("k = "..tostring(k));
    	print("v = "..tostring(v));
    end
    
end