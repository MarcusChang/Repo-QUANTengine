local quantCore = QuantCORE();
local positionManager = quantCore:PositionManager();


--local strategy = "SIM.O.XJO.SEP2013.2300.C.0";
--It's a strategy ID
local strategy =  "SIM.O.XJO.STRATEGIES.TIGHT.TMC.BUY.1-0.[SIM.O.XJO.SEP2013.2850.C.0].SELL.1-0.[SIM.O.XJO.SEP2013.4450.P.0]"
--It's a strategy path
--local strategy = "SIM.O.OOESX.STRATEGIES.TIGHT.BOX.BUY.1.[SIM.O.OOESX.JUN2011.5100.C.0].SELL.1.[SIM.O.OOESX.JUN2011.5100.P.0].BUY.1.[SIM.O.OOESX.JUN2011.6100.P.0].SELL.1.[SIM.O.OOESX.JUN2011.6100.C.0]"
local vol_strategy = "SIM.F.NK.STRATEGIES.TIGHT.VTS.SELL.1-0.[SIM.F.NK.SEP2013].BUY.1-0.[SIM.F.NK.DEC2013]";
--local vol_strategy = "SIM.F.NK.STRATEGIES.TIGHT.VTS.SELL.1-0.[SIM.F.NK.SEP2013].BUY.1-0.[SIM.O.NK.DEC2013.4000.C.0]";

--It's a strategy ID
--local vol_strategy = "SIM.F.NK.STRATEGIES.TIGHT.VTS.SELL.1-0.[SIM.F.NK.JUN2013].BUY.1-0.[SIM.F.NK.AUG2013]"
--It's a strategy Path
--local vol_strategy = "SIM.O.APPLES.STRATEGIES.TIGHT.VOL.BUY.1.[SIM.O.APPLES.SEP2011.85.C.0].SELL.8-1.EUR-100-0.[SIM.F.APPLES.SEP2011]"

function OnStart()


    local parser3 = Util:ProductParser(strategy);
    local parser5 = Util:ProductParser(vol_strategy);
    
        
    if parser3:IsStrategy() then
    	--it's a strategy product.
    	local strategyParser_01 = parser3:Strategy();
    	local strategyType_01 = strategyParser_01:StrategyType();
    	print ("StrategyType is:"..StrategyTypeToString(strategyType_01));
    	local tightStrategy_01 = strategyParser_01:TightStrategy();
    	print ("TightStrategy is:"..tostring(tightStrategy_01));
    	
    	local legs = strategyParser_01:Legs();
    	print ("Legs is:"..tostring(legs));
    	for i=1,legs do
    		print("    leg"..tostring(i).." path:"..strategyParser_01:Leg(i));
    		print("    leg"..tostring(i).." ratio:"..strategyParser_01:Ratio(i));
    		print("    leg"..tostring(i).." side:"..BuySellToString(strategyParser_01:BuySell(i)));
    	end;
    	--[[
    	if strategyParser_01:IsVolStrategy() then	
    		print ("The strategy is vol strategy.");
    		print ("VolLeg is :"..strategyParser_01:VolLeg());
    		print ("Price is :"..tostring(strategyParser_01:Price()));
    		print ("Currency is :"..strategyParser_01:Currency());
    		print ("Delta is :"..tostring(strategyParser_01:Delta()));
    	end;
    	--]]
    end;
    
    
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
    	local strategyParser_02 = parser5:Strategy();
    	local strategyType_02 = strategyParser_02:StrategyType();
    	print ("StrategyType is:"..StrategyTypeToString(strategyType_02));
    	local tightStrategy_02 = strategyParser_02:TightStrategy();
    	print ("TightStrategy is:"..tostring(tightStrategy_02));
    	
    	local legs = strategyParser_02:Legs();
    	print ("Legs is:"..tostring(legs));
    	for i=1,legs do
    		print("    leg"..tostring(i).." path:"..strategyParser_02:Leg(i));
    		print("    leg"..tostring(i).." ratio:"..strategyParser_02:Ratio(i));
    		print("    leg"..tostring(i).." side:"..BuySellToString(strategyParser_02:BuySell(i)));
    	end;
    	--[[
    	if strategyParser_02:IsVolStrategy() then	
    		print ("The strategy is vol strategy.");
    		print ("VolLeg is :"..strategyParser_02:VolLeg());
    		print ("Price is :"..tostring(strategyParser_02:Price()));
    		print ("Currency is :"..strategyParser_02:Currency());
    		print ("Delta is :"..tostring(strategyParser_02:Delta()));
    	end;
		--]]
    end;
--	SendCompletionCode(QS_COMPLETION_CODE_SUCCESS, "Time Out");
end

function OnStop()

end