local quantCore = QuantCORE();
local positionManager = quantCore:PositionManager();

function ReturnStrategy(strategy1, vol_strategy)

    local parser3 = Util:ProductParser(strategy1);
    local parser5 = Util:ProductParser(vol_strategy);
      
        
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
	SendCompletionCode(QS_COMPLETION_CODE_SUCCESS, "Time Out");
end

function OnStart()

	local strategyBuilder = Util:StrategyBuilder()
	strategyBuilder:External(true)
--[[	
	local productPath_1 = "SIM.O.XJO.SEP2012.5100.C.0"
	local side_1 = QS_BUY 
	local ratio_1 = 1 
	local price1 = 2343.86
	
	local productPath_2 = "SIM.O.XJO.SEP2012.5050.C.0"
	local side_2 = QS_BUY 
	local ratio_2 = 1
	local price2 = 2331.67
	
	--begin to combine the strategy legs 
	
	strategyBuilder:AddTMCLeg(productPath_1, side_1, ratio_1, price1)
	strategyBuilder:AddTMCLeg(productPath_2, side_2, ratio_2, price2)
	
	local strategy1 = strategyBuilder:StrategyID()
	print("startegy1 = "..tostring(strategy1))
	
	--begin to combine the TMC legs
	
	local productPath3 = "SIM.O.XJO.DEC2012.3850.C.0"
	local side3 = QS_BUY
	local ratio3 = 1
	local price3 = 3999
	
	local productPath4 = "SIM.O.XJO.DEC2012.3950.C.0"
	local side4 = QS_BUY
	local ratio4 = 1
	local price4 = 2999
	
	strategyBuilder:AddTMCLeg(productPath3, side3, ratio3, price3)
	strategyBuilder:AddTMCLeg(productPath4, side4, ratio4, price4)
	
	local vol_strategy = strategyBuilder:StrategyID()
	print("vol_strategy ="..tostring(vol_strategy))

]]--	
	
	
	local productPath_1 = "SIM.O.XJO.JUN2013.2000.C.0"
	local side_1 = QS_BUY
	--local side_1 = nil
	local ratio_1 = 1.000
	--local ratio_1 = nil 
	local Price = 4301.00 
	
	
	local productPath_2 = "SIM.O.XJO.JUN2013.2550.C.0"
	local side_2 = QS_BUY 
	local ratio_2 = 1
	local price2 = 2331.67
	
	local productPath_3 = "SIM.O.XJO.JUN2013.3300.C.0"
	local side_3 = QS_BUY
	local price3 = 97.59
	local ratio_3 = 1
	
	--begin to combine the strategy legs 
	
	strategyBuilder:AddLeg(productPath_1, side_1, ratio_1)
	strategyBuilder:AddLeg(productPath_2, side_2, ratio_2)
	strategyBuilder:AddLeg(productPath_3, side_3, ratio_3)
	
	local strategy1 = strategyBuilder:StrategyPath()
	print("startegy1 = "..tostring(strategy1))
	
	--begin to combine the TMC legs
	
	local productPath4 = "SIM.F.XJO.SEP2013"
	--local productPath4 = nil
	local side4 = QS_BUY
	--local side4 = nil
	local Delta = 1
	--local Delta = nil
	local price4 = 15000
	--local price4 = nil
	
	local productPath5 = "SIM.O.XJO.JUN2013.3800.C.0"
	local side5 = QS_BUY
	local ratio5 = 1
	local price5 = 2999
	
	strategyBuilder:AddVolLeg(productPath4, side4, Delta, price4)
	--strategyBuilder:AddVolLeg(nil, side4, Delta, price4)
	strategyBuilder:AddLeg(productPath5, side5, ratio5)
	
	local vol_strategy = strategyBuilder:StrategyPath()
	print("vol_strategy ="..tostring(vol_strategy))
	
	
	
	--ReturnStrategy(strategy1, vol_strategy) 
	ReturnStrategy(strategy1, vol_strategy)
end
--It's a strategy ID
--local strategy = "SIM.S.TIGHT.81.BUY.1-0.[SIM.O.XJO.SEP2012.2250.P.0].BUY.1-0.[SIM.O.XJO.SEP2012.2500.C.0]"
--It's a strategy path
--local strategy = "SIM.O.OOESX.STRATEGIES.TIGHT.BOX.BUY.1.[SIM.O.OOESX.JUN2011.5100.C.0].SELL.1.[SIM.O.OOESX.JUN2011.5100.P.0].BUY.1.[SIM.O.OOESX.JUN2011.6100.P.0].SELL.1.[SIM.O.OOESX.JUN2011.6100.C.0]"

--It's a strategy ID
--local vol_strategy = "SIM.S.TIGHT.81.BUY.1-0.[SIM.O.XJO.MAR2013.4450.C.0].BUY.1-0.[SIM.F.XJO.MAR2013]"
--It's a strategy Path
--local vol_strategy = "SIM.O.APPLES.STRATEGIES.TIGHT.VOL.BUY.1.[SIM.O.APPLES.SEP2011.85.C.0].SELL.8-1.EUR-100-0.[SIM.F.APPLES.SEP2011]"



function OnStop()

end
