local QuantCORE = QuantCORE();
local ParameterManager = QuantCORE:ParameterManager();
local spec_name = "ZERO";
local newKey = "QA_IR_TEST_MAC1"
local testFlag = false;

function OnStart()
    print("OnStart -- Subcribe parameter");
    --ParameterManager:SubscribeParameter(spec_name, QS_INTERESTRATE_SPEC, false, "InterestRate.lua" );
    ParameterManager:SubscribeParameter(spec_name, QS_INTERESTRATE_SPEC, true, "stateless.lua" );
    --print("5 secs timer start")
    --OnTimer(1, 5000, "InterestRate.lua");
    TestCreateInstance()
end
--[[
function OnTimer(id)
    print("OnTimer -- Unsubscribe parameter");
    
end
--]]
function TestCreateInstance()

	if (testFlag) then
		print("Tested!")
		return;
	end
	
	print("Begin to test new spec---------------------");
    local newSpec = InterestRateSpecification:CreateInstance();
    newSpec:SetKey(newKey);
    
    local newSeries = InterestRateSeries:CreateInstance();
    newSeries:SetCurrency("HKD");
    
    local newRate1 = InterestRate:CreateInstance();
    --newRate1:SetPeriod(68);
    newRate1:SetRate(0.048994);
    newRate1:SetLength(10);

    local newRate2 = InterestRate:CreateInstance();
    --newRate2:SetPeriod(68);
    newRate2:SetRate(0.088995);
    newRate2:SetLength(20);
 
    local newRate3 = InterestRate:CreateInstance();
    --newRate3:SetPeriod(68);
    newRate3:SetRate(0.098996);
    newRate3:SetLength(30);
           
    local result1 = newSeries:InsertRate(newRate1);
    local result2 = newSeries:InsertRate(newRate2);
    local result3 = newSeries:InsertRate(newRate3);
    
    print("insert Rate 1 result is: "..tostring(result1));
    print("insert Rate 2 result is: "..tostring(result2));
    print("insert Rate 3 result is: "..tostring(result3));
    
    local rt = newSpec:InsertRateSeries(newSeries);
    print("Insert new series to spec result is: "..tostring(rt));
    
    print("Subscribe to the new key");
    ParameterManager:SubscribeParameter(newKey, QS_INTERESTRATE_SPEC, false, "InterestRate.lua" );
    
    print("Begin to set new key"..newKey);
    ParameterManager:SetInterestRateSpec(newSpec);
    testFlag = true;
    
    
    local Rates_table = newSeries:GetRates();
    print("Rates_table ="..tostring(Rates_table));
    
    if (Rates_table == nil) then
    	print("the Rates_table = nil")
    end
    
    print("Rates_table size ="..tostring(#Rates_table))
     
    for k, v in pai(Rates_table) do
    	print("k = "..tostring(k));
    	print("v = "..tostring(v));
    end
    

    
end


function OnInterestRateSpec(spec, fromSnapshot)
	if fromSnapshot == true then
		print("---------fromSnapshot = true--------------")
	else
		print("---------fromSnapshot = false-------------")
	end
	 
	print("New spec callback! Ky is: "..spec:GetKey());
	DisplaySpec(spec)
	--ParameterManager:UnsubscribeParameter(newKey, QS_INTERESTRATE_SPEC, false, "InterestRate.lua" );
	--SendCompletionCode(0, "Complete");
end

function DisplaySpec(spec)
	print("Display spec content--------------------------------------------------")
    -- Get a table of interestRate series defined in spec
    local rateSeriesTable = spec:GetRateSeries();
    if rateSeriesTable == nil then
        print("No InterestRate series get from InterestRateSpecification");
    else
        print("InterestRate series number in spec="..#rateSeriesTable);
        local index = 1;
        while ( index <= #rateSeriesTable ) do
            local rateSeries = rateSeriesTable[index];
            
            print("Currency="..rateSeries:GetCurrency());
            
            local rateTable = rateSeries:GetRates();
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
end

function OnStop()
	--ParameterManager:UnsubscribeParameter(spec_name, QS_INTERESTRATE_SPEC, false, "InterestRate.lua" );
    ParameterManager:UnsubscribeParameter(spec_name, QS_INTERESTRATE_SPEC, true, "stateless.lua" );
    
end

--[[
function OnInterestRateSpec(spec)
print("OnInterestRateSpec");
    --print key in spec
    print("key="..spec:GetKey());
    
    --find a interest rate series in spec
    local rateSeries = spec:FindRateSeries("CHF");
    if  rateSeries == nil then
          print("No interest rate series get from InterestRateSpecification");
    else
          print("Currency="..rateSeries:GetCurrency());
          local rateTable = rateSeries:GetRates();
          local i = 1;
          while (i <= #rateTable)do
                local rate = rateTable[i];
                print("Length: "..tostring(rate:GetLength()));
                print("Rate: "..tostring(rate:GetRate()));
                i = i + 1;
           end
    end
    
            
    local rateInstance = InterestRate:CreateInstance();
    rateInstance:SetLength(100);
    rateInstance:SetRate(35.5);
    
    local seriesInstance = InterestRateSeries:CreateInstance();
    seriesInstance:SetCurrency("GBP");
    seriesInstance:InsertRate(rateInstance);
    
    local speseriesInstance = InterestRateSpecification:CreateInstance();
    speseriesInstance:InsertRateSeries(seriesInstance);
    spec:InsertRateSeries(seriesInstance);
    

end
--]]
