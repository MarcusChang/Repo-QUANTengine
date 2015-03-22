local QuantCORE = QuantCORE();
local ParameterManager = QuantCORE:ParameterManager();
local spec_name = Util:LoadVarString("INTERESTRATE_SPEC");

firsttime = true
function OnStart()
    print("OnStart -- Subcribe parameter");
    ParameterManager:SubscribeParameter(spec_name, QS_INTERESTRATE_SPEC, false, "" );
    
    Timer(1, 5000, "");
end

function OnTimer(id)
    print("OnTimer -- Unsubscribe parameter");
    ParameterManager:UnsubscribeParameter(spec_name, QS_INTERESTRATE_SPEC, false, "" );
    
    SendCompletionCode(0, "Complete");
end

function OnStop()

end


function OnInterestRateSpec(spec)
print("OnInterestRateSpec");
    --print key in spec
    print("key="..spec:GetKey());
    
    --find a interest rate series in spec
    --[[local rateSeries = spec:FindRateSeries("USD");
    if  rateSeries == nil then
          print("No interest rate series get from rsInterestRateSpecification");
    else
          print("Currency="..rateSeries:GetCurrency());
          local rateTable = rateSeries:GetRates();
          local i = 1;
          while (i <= #rateTable)do
                local rate = rateTable[i];
                print("Period: "..tostring(rate:GetPeriod()));
                print("Rate: "..tostring(rate:GetRate()));
                print("Length: "..tostring(rate:GetLength()))
                i = i + 1;
           end
    end--]]
    
    if firsttime == true then
    spec:RemoveRateSeries("USD")
   
    ParameterManager:SetInterestRateSpec(spec);
    print ("USDremoved")
    firsttime = false
    end
end