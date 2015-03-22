--Get all strategies registered by rsStrategyInformation. It returns the 3xN table. Each element in table has tree values. 
--The first part is StrategyType, which is an integer type, the second part is a string to represent the strategies name and the last part is a string to describle the strategy

function OnStart()
	local StrategyTable= Util:GetAllStrategies(); 
	print (#StrategyTable)
		print (StrategyTable[1])
		for i,v in ipairs (StrategyTable)
		do  for i2,v2 in ipairs(v) do 
			print(v2) end 
						
		end 
end

function OnStop()

end