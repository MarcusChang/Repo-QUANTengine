local QuantCORE = QuantCORE();
local ParameterManager = QuantCORE:ParameterManager();
local newKey = "QA_XJO_MAC1_TEST"
--local newKey = nil
local testFlag = false;

function OnUnderlyingSpec(spec, fromSnapshot)
	
	if fromSnapshot == true then
		print("--------fromSnapshot = true--------")
	else
		print("--------fromSnapshot = false-------")
	end
	
 
   if (testFlag) then
	  print("Tested!")
	  return;
   end  
    print("OnUnderlyingSpec");
    
    --print details in underlying spec
    print("key="..spec:GetKey());
	print("Root underlying = "..spec:GetRootUnderlying());
    print("Root delta scaling = "..spec:GetRootDeltaScaling());
    
--  print("Front month underlying = "..spec:GetFrontMonthUnderlying());
     print("Getting pricing rule ...... ");
    local getRules = spec:GetPricingRule();

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
    
    print("Roll Method = "..CalculationMethodToString(spec:GetCalculationMethod()));

-------------- to test Get functionality-----------------------------------
   local underExpiries = spec:GetUnderlyingExpiries();
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

 ---------to test Find, insert, remove functionalities -----------------------------------------  
        local     UnderlyingExpiry = spec:FindUnderlyingExpiry("SIM.F.XJO.DEC2012")
          if UnderlyingExpiry ==nil then 
                 print("No UnderlyingExpiry found from UnderlyingSpecification");    
                 else
                 print("UnderlyingExpiry found successfully from UnderlyingSpecification");                	
            print("Outright ID = "..UnderlyingExpiry:GetOutright());
            print("Underlying ID = "..UnderlyingExpiry:GetUnderlying());
            print("Price offset  = "..UnderlyingExpiry:GetPriceOffset());

               UnderlyingExpiry:SetOutright("SIM.O.XJO.DEC2012.>");
               UnderlyingExpiry:SetUnderlying("SIM.F.XJO.DEC2012");
               UnderlyingExpiry:SetPriceOffset(0);
               
               	flag = spec:InsertUnderlyingExpiry(UnderlyingExpiry);
                print ("flag value"..tostring(flag))
                spec:RemoveUnderlyingExpiry("SIM.F.XJO.DEC2012");
               -- ParameterManager:SetUnderlyingSpec(spec)
            end 
    
    



------------------testing create new instance function	------------------------------------
 local newUnderlyingSpec = UnderlyingSpecification:CreateInstance();
      
      newUnderlyingSpec:SetKey(newKey)
      newUnderlyingSpec:SetRootUnderlying("SIM.F.XJO.>")
      newUnderlyingSpec:SetRootDeltaScaling("SIM.F.XJO.>")
      newUnderlyingSpec:SetFrontMonthUnderlying("SIM.F.XJO.DEC2012")

 
    print("Setting pricing rules......")
    local rules = {
    	  QS_THEO_PRICING_RULE_ASK,
        QS_THEO_PRICING_RULE_BID,
    	  QS_THEO_PRICING_RULE_USER,
        QS_THEO_PRICING_RULE_MID_BIDASK,
        QS_THEO_PRICING_RULE_LAST_TRADE,
        QS_THEO_PRICING_RULE_OPEN,
        QS_THEO_PRICING_RULE_CLOSE,
        QS_THEO_PRICING_RULE_WEIGHTED
        };
        
    newUnderlyingSpec:SetPricingRule(rules);
    
    print("Getting pricing rule ...... ");
    local getRules = newUnderlyingSpec:GetPricingRule();

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
    
    newUnderlyingSpec:SetCalculationMethod(1)
    
    local newUnderlyingExpiry1 = UnderlyingExpiry:CreateInstance()     
    newUnderlyingExpiry1:SetOutright("SIM.F.XJO.DEC2012");
    newUnderlyingExpiry1:SetUnderlying("SIM.F.XJO.DEC2012");
       
    local newUnderlyingExpiry2 = UnderlyingExpiry:CreateInstance()     
    newUnderlyingExpiry2:SetOutright("SIM.F.XJO.DEC2012");
    newUnderlyingExpiry2:SetUnderlying("SIM.F.XJO.DEC2012");
       
    local newUnderlyingExpiry3 = UnderlyingExpiry:CreateInstance()     
    newUnderlyingExpiry3:SetOutright("SIM.O.XJO.DEC2012.>");
    newUnderlyingExpiry3:SetUnderlying("SIM.F.XJO.DEC2012");
    
local result1 = newUnderlyingSpec:InsertUnderlyingExpiry(newUnderlyingExpiry1)  
local result2 = newUnderlyingSpec:InsertUnderlyingExpiry(newUnderlyingExpiry2)  
local result3 = newUnderlyingSpec:InsertUnderlyingExpiry(newUnderlyingExpiry3)       
 
    print("insert Expiry 1 result is: "..tostring(result1));
    print("insert Expiry 2 result is: "..tostring(result2));
    print("insert Expiry 3 result is: "..tostring(result3));      
  
   print("Subscribe to the new key");
      ParameterManager:SubscribeParameter(newKey, QS_UNDERLYING_SPEC, false, "statefull.lua" );

  print("Begin to set new key"..newKey);
      ParameterManager:SetUnderlyingSpec(newUnderlyingSpec);  
     
      
      

    
--[[    

      
---------Test clear function-----------------------    
spec:ClearAllExpiries()  
ParameterManager:SetUnderlyingSpec(spec);  

testFlag = true;        
end

]]--
print("-------------->END<------------------")

end
