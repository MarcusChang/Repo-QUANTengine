local quantCore = QuantCORE();
local positionManager = quantCore:PositionManager();

local option  =  "SIM.O.XJO.JUN2013.2000.C.0";

local future  =  "SIM.F.XJO.SEP2013";


--It's a strategy ID
local strategy = "SIM.O.XJO.STRATEGIES.TIGHT.TMC.BUY.1-0.[SIM.O.XJO.JUN2013.2150.C.0].BUY.1-0.[SIM.O.XJO.JUN2013.2300.C.0]"
--It's a strategy path
--local strategy = nil;

local wildcard = "SIM.F.>";

--It's a strategy ID
--local vol_strategy = "SIM.S.TIGHT.19.BUY.1.[SIM.O.APPLES.SEP2011.85.C.0].SELL.8-1.EUR-100-0.[SIM.F.APPLES.SEP2011]"
--It's a strategy Path
--local vol_strategy = "SIM.O.APPLES.STRATEGIES.TIGHT.VOL.BUY.1.[SIM.O.APPLES.SEP2011.85.C.0].SELL.8-1.EUR-100-0.[SIM.F.APPLES.SEP2011]"

function OnStart()
	local parser1 = Util:ProductParser(option);
    local parser2 = Util:ProductParser(future);
    local parser3 = Util:ProductParser(strategy);
--    local parser4 = Util:ProductParser(wildcard);
--    local parser5 = Util:ProductParser(vol_strategy);
    
    local type1 = parser1:ProductType();
    print ("Option type is:"..ProductTypeToString(type1));
    local productName1 = parser1:ProductName();
    print ("Option product name is:"..productName1);
    local product1 = parser1:Product();
    print ("Option product is:"..product1);
    local simulation1 = parser1:Simulation();
    print ("Option simulation flag is:"..tostring(simulation1));
    local strike1 = parser1:Strike();
    print ("Option strike is:"..tostring(strike1));
    local callPut1 = parser1:CallPut();
    print ("Option Call/Put is:"..CallPutToString(callPut1));
    local versionNr1 = parser1:VersionNr();
    print ("Option versionNr is:"..versionNr1);
    local series1 = parser1:Series();
    print ("Option series is:"..series1);
   
    local type2 = parser2:ProductType();
    print ("Future type is:"..ProductTypeToString(type2));
    local productName2 = parser2:ProductName();
    print ("Future product name is:"..productName2);
    local product2 = parser2:Product();
    print ("Future product is:"..product2);
    local simulation2 = parser2:Simulation();
    print ("Future simulation flag is:"..tostring(simulation2));
      
    local type3 = parser3:ProductType();
    print ("Strategy type is:"..ProductTypeToString(type3));
    local productName3 = parser3:ProductName();
    print ("Strategy product name is:"..productName3);
    local product3 = parser3:Product();
    print ("Strategy product is:"..product3);
    local simulation3 = parser3:Simulation();
    print ("Strategy simulation flag is:"..tostring(simulation3));
    
    if parser3:IsStrategy() then
    	--it's a strategy product.
    	local strategyParser = parser3:Strategy();
    	local strategyType = strategyParser:StrategyType();
    	print ("StrategyType is:"..StrategyTypeToString(strategyType));
    	local tightStrategy = strategyParser:TightStrategy();
    	print ("TightStrategy is:"..tostring(tightStrategy));
    	
    	local legs = strategyParser:Legs();
    	print ("Legs is:"..tostring(legs));
    	for i=1,legs do
    		print("    leg"..tostring(i).." path:"..strategyParser:Leg(i));
    		print("    leg"..tostring(i).." ratio:"..strategyParser:Ratio(i));
    		print("    leg"..tostring(i).." side:"..BuySellToString(strategyParser:BuySell(i)));
    	end;
    	
    	if strategyParser:IsVolStrategy() then
    		print ("The strategy is vol strategy.");
    		print ("VolLeg is :"..strategyParser:VolLeg());
    		print ("Price is :"..tostring(strategyParser:Price()));
    		print ("Currency is :"..strategyParser:Currency());
    		print ("Delta is :"..tostring(strategyParser:Delta()));
    	end;
    end;
    
--[[  
    local type4 = parser4:ProductType();
    print ("Wild product type is:"..ProductTypeToString(type4));
    local productName4 = parser4:ProductName();
    print ("Wild product'product name is:"..productName4);
    local product4 = parser4:Product();
    print ("Wild product'product is:"..product4);
    local simulation4 = parser4:Simulation();
    print ("Wild product simulation flag is:"..tostring(simulation4)); 
--    local strike4 = parser4:Strike();
--    print ("Wild product strike is:"..tostring(strike4));
--    local callPut4 = parser4:CallPut();
--    print ("Wild product Call/Put is:"..CallPutToString(callPut4));
--    local versionNr4 = parser4:VersionNr();
--    print ("Wild product versionNr is:"..versionNr4);
    local series4 = parser4:Series();
    print ("Wild product series is:"..series4);
--]] 
 --[[
    
   local type5 = parser5:ProductType();
    print ("Strategy type is:"..ProductTypeToString(type5));
    local productName5 = parser5:ProductName();
    print ("Strategy product name is:"..productName5);
    local product5 = parser5:Product();
    print ("Strategy product is:"..product5);
    local simulation5 = parser5:Simulation();
    print ("Strategy simulation flag is:"..tostring(simulation5));
    
    if QS_PRODUCT_TYPE_STRATEGY==type5 then
    	--it's a strategy product.
    	local strategyParser = parser5:Strategy();
    	local strategyType = strategyParser:StrategyType();
    	print ("StrategyType is:"..StrategyTypeToString(strategyType));
    	local tightStrategy = strategyParser:TightStrategy();
    	print ("TightStrategy is:"..tostring(tightStrategy));
    	
    	local legs = strategyParser:Legs();
    	print ("Legs is:"..tostring(legs));
    	for i=1,legs do
    		print("    leg"..tostring(i).." path:"..strategyParser:Leg(i));
    		print("    leg"..tostring(i).." ratio:"..strategyParser:Ratio(i));
    		print("    leg"..tostring(i).." side:"..BuySellToString(strategyParser:BuySell(i)));
    	end;
    	
    	if strategyParser:IsVolStrategy() then
    		print ("The strategy is vol strategy.");
    		print ("VolLeg is :"..strategyParser:VolLeg());
    		print ("Price is :"..tostring(strategyParser:Price()));
    		print ("Currency is :"..strategyParser:Currency());
    		print ("Delta is :"..tostring(strategyParser:Delta()));
    	end;
    end;
    
  ]]--  
    
    
--	SendCompletionCode(QS_COMPLETION_CODE_SUCCESS, "Time Out");
end

function OnStop()

end