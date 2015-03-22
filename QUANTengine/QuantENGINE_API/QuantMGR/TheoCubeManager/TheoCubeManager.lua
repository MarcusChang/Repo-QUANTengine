local QuantCORE = QuantCORE();
local TheoCubeManager=QuantCORE:TheoCubeManager();
local TheoManager = QuantCORE:TheoManager();
local NamedEventManager = QuantCORE:NamedEventManager();
local StrategyPath = "SIM.O.XJO.STRATEGIES.TIGHT.TMC.BUY.1-0.[SIM.O.XJO.MAY2013.4175.C.0].BUY.1-0.[SIM.O.XJO.MAY2013.4250.C.0].BUY.1-0.[SIM.O.XJO.MAY2013.4375.C.0]"
local pricingSpec = "QA_XJO_MAC1";
local productPath = "SIM.F.XJO.SEP2013";

function OnStart()
 
	local referencePrice =5595
	local cubeWidth=10
	local incrementSize=1
	local MyCubeID = TheoCubeManager:CreateCube(pricingSpec,referencePrice,cubeWidth,incrementSize)

	print("MyCubeID is"..MyCubeID);

	TheoCubeManager:SubscribeTheoCube(MyCubeID,"TheoCubeManager.lua");

	local IsRefreshed = TheoCubeManager:Refresh(MyCubeID);
	print("-------->TheoCubeManager:Refresh()----->"..tostring(IsRefreshed));
--[[	
	local IsDestroyed = TheoCubeManager:DestroyCube(MyCubeID);
	print("-------->TheoCubeManager:DestroyCube()----->"..tostring(IsDestroyed));
--]]
end 



function OnCubeReady(id)
	 print("id is"..id)
	
	 local theos =TheoCubeManager:GetTheos(MyCubeID,5598,productPath)
	
     if theos ~=nil then
     	print("------------->TheoCubeManager:GetTheos()------------->")
     	print("Total"..#theos.."theo retrieved");
     	print("TheoPrice()"..theos[1]:TheoPrice());
     	
     	for a, b in pairs(StrTheos) do
     		print("--------->a------->"..tostring(a));
     		print("--------->b------->"..tostring(b));
		end
     	
     else 
     	print("Cube"..id "is not ready");
     end
     
     local StrTheos = TheoCubeManager:StrategyTheos(MyCubeID, 5598, StrategyPath)
     
     if StrTheos ~= nil then
     	print("------------->TheoCubeManager:StrategyTheos()------------->")	
     	print("Total"..#StrTheos.."StrTheos retrieved");
     	print("StrTheosPrice()"..StrTheos[1]:TheoPrice());
     	
     	for k, v in pairs(StrTheos) do
     		print("--------->k------->"..tostring(k));
     		print("--------->v------->"..tostring(v));
		end
     	
     else
     	print("Cube "..id.." is not ready");
     end
     
     local PR = TheoCubeManager:PriceRange(MyCubeID)
     if PR ~= nil then
     	print("---------->TheoCubeManager:PriceRange()--------->")
     	for i, j in pairs(PR) do
     		print("I = "..tostring(i));
     		print("J = "..tostring(j));
     	end
     end
     
     local readyIs = TheoCubeManager:CubeReady(MyCubeID)
     print("CubeReady is "..tostring(readyIs)) 
     
     TheoManager:ResetTheos(pricingSpec);
     --SendCompletionCode(0,"Complete")
end 


function OnStop() 
	TheoCubeManager:UnsubscribeTheoCube(MyCubeID,"TheoCubeManager.lua");
end
