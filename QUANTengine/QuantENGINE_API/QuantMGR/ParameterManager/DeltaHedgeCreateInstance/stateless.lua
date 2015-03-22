local QuantCORE = QuantCORE();
local ParameterManager = QuantCORE:ParameterManager();

function OnParameterNotify( key, paramType )
	print("OnParameterNotify()");
	print("Key="..key);
	print("Parameter type="..ParameterTypeToString(paramType));

	-- Get table of DeltaHedgeSpecification for key
	local specs = ParameterManager:GetDeltaHedgeSpec(key);
	
	if specs == nil then 
		print("No DeltaHedgeSpecification found in parameter manager for key="..key);
	else
		print("The DeltaHedgeSpecification number ="..#specs);
	
		-- Print details in each DeltaHedgeSpecification
		local index = 1;
		
		while (index <= #specs) do 
			print("Key of spec"..index.."="..specs[index]:GetKey());
			local products = specs[index]:Products();
			if products ~= nil then
				print("Products number in spec"..index.."="..#products);
				-- Print all products in each DeltaHedgeSpecification
				local productNum = 1;
				while (productNum <= #products) do
					print("Product"..productNum.."="..products[productNum]);
					productNum = productNum+1
				end
			end
		
			index = index+1
		
		end
	end
end