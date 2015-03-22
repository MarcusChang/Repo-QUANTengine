local QuantCORE = QuantCORE();
local ParameterManager = QuantCORE:ParameterManager();
changeSpec = true;


--to change the name to OnDeltaHedgeSpec, then user can test Products(),AddProduct(),GetKey()
function OnDeltaHedgeSpec(spec) 
	print("OnDeltaHedgeSpec");

	--print key in spec
	print("key="..spec:GetKey());
	-- Get a table of products defined in spec
	local products = spec:Products();
	if products == nil then
		print("No products defined in DeltaHedgeSpecification");
	else
		print("Products number in spec="..#products);
		local index = 1;
		while ( index <= #products ) do
			print("Product="..products[index]);
			index = index + 1;
		end

	end

	if( changeSpec == true ) then 
		spec:AddProduct("SIM.O.NK.>");
		ParameterManager:SetDeltaHedgeSpec(spec);
		changeSpec = false; --just change once
	end
end


-- change the function name to OnDeltaHedgeSpec() , then user can test ClearProducts()

function OnDeltaHedgeSpec123(spec)

	print("OnDeltaHedgeSpec");
	print("key="..spec:GetKey());
	spec:SetKey("QA_NK_DH")
	print("key 2 --->"..spec:GetKey())
	local add = spec:AddProduct("SIM.O.NK.>");
	--ParameterManager:SetDeltaHedgeSpec(spec)
	print("add ="..tostring(add))
	local clear = spec:ClearProducts();
	ParameterManager:SetDeltaHedgeSpec(spec);
	print("clear ="..tostring(clear));
end 