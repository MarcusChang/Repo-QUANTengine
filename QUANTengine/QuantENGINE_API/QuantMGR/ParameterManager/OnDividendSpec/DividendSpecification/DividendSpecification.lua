local QuantCORE = QuantCORE();
local ParameterManager = QuantCORE:ParameterManager();
local spec_name ="MarcusTesting_Fit";

function OnStart()
    print("OnStart -- Subcribe parameter");
    ParameterManager:SubscribeParameter(spec_name, QS_DIVIDEND_SPEC, false, "DividendSpecification.lua" );
    --ParameterManager:SubscribeParameter(spec_name, QS_DIVIDEND_SPEC, true, "stateless.lua" );
    --Timer(1, 5000, "Dividend.lua");
end
--[[
function OnTimer(id)
    print("OnTimer -- Unsubscribe parameter");
    
    SendCompletionCode(0, "Complete");
end
--]]

--[[
-- the following can test GetKey(), GetProducts(), GetDate(),GetAmout

function OnDividendSpec(spec)
	print("Key is"..spec:GetKey());
	
	local productDividendTable = spec:GetProducts();
		
	print("#productDividendTable is "..#productDividendTable);
	
	for i = 1, #productDividendTable do
		
		local productDividend = productDividendTable[i];
		
		local dividendTable = productDividend:GetDividends();
		
		if dividendTable == nil then 
			print("The dividendTable == nil")
		end
		
		print("Product="..productDividend:GetProduct());
		
		print("#dividendTable is "..#dividendTable)
		
		local dividend = dividendTable[1]
		if dividend == nil then 
			print("-------------> the dividend = nil <------------")
		else
			print("------------------------->dividend = "..tostring(dividend))
		end
			
		print("DividenDate is "..dividend:GetDate():AsString());
		print("DividendAmount is "..dividend:GetAmount());
	
	end 
		
end 
--]]

--[[
-- the following is for testing FindProductDividend 

function OnDividendSpec(spec)

	local productDividendTable = spec:GetProducts();
		
	print("#productDividendTable is "..#productDividendTable)
	
	--ProductDividendObj = spec:FindProductDividend(nil)
	ProductDividendObj = spec:FindProductDividend("SIM.E.RIO")
	if ProductDividendObj ~= nil then
		print("ProductDividendObj -> "..tostring(ProductDividendObj))
	else
		print("ProductDividendObj -> nil")
	end
	
	print("product is "..ProductDividendObj:GetProduct());
	
	local Dividends = ProductDividendObj:GetDividends(); 
	
	print("dividend date is"..Dividends[1]:GetDate():AsString());
	print("dividend amount is"..Dividends[1]:GetAmount())
	
end 
--]]	
	

--[[
-- this is for Insert dividend; and RemoveProductDividend()

function OnDividendSpec(spec)
	
	print("OnDividend happen")
	
local	ProductDividendObj =spec:FindProductDividend("SIM.F.NK.OCT2013");
	
	print("ProductDividend"..ProductDividendObj:GetProduct())
	
local	DividendObj = ProductDividendObj:FindDividend(Date:FromString("20130624"))
	
	print("dividend date is"..DividendObj:GetDate():AsString());
	print("dividend amount is"..DividendObj:GetAmount());
	
	DividendObj:SetDate(Date:FromString("20130630"))
	--DividendObj:SetDate(Date:FromString(nil))
	DividendObj:SetAmount(5000)
	
	print("dividend date is"..DividendObj:GetDate():AsString());
	print("dividend amount is"..DividendObj:GetAmount());
	
	
	flag = ProductDividendObj:InsertDividend(DividendObj);
	
	print ("flag value"..tostring(flag))
	
	flag2 = spec:InsertProductDividend(ProductDividendObj)
		
	print ("flag2 value"..tostring(flag2))
	
	flag3 = ProductDividendObj:RemoveDividend(Date:FromString("20130902"))
--	flag3 = ProductDividendObj:RemoveDividend(Date:FromString(nil))	
	print("flag3 value"..tostring(flag3));
	spec:InsertProductDividend(ProductDividendObj); 

	ParameterManager:SetDividendSpec(spec);
	
end 
--]]
--[[
function OnDividendSpec(spec)
	print("OnDividend happen");	
	
    NewProductDivi = ProductDividend:CreateInstance();
    NewProductDivi:SetProduct("SIM.F.XJO.JUN2013");
    ParameterManager:SetDividendSpec(NewProductDivi)

end
--]]

--[[
--this is for remove dividend ; change the function name to OnDividendSpec, then can test RemoveProductDividend()

function OnDividendSpec(spec)
	
	print("OnDividend happen")
	
    --ProductDividendObj =spec:FindProductDividend("SIM.O.XJO.SEP2013.2300.C.0");
	
	flag = spec:RemoveProductDividend("SIM.O.XJO.SEP2013.2300.C.0")
	--flag = spec:RemoveProductDividend(nil)
	
	print("flag value is "..tostring(flag))
	ParameterManager:SetDividendSpec(spec);
	
end  
--]]

--[[
--this is for clear all dividend; change the function name to OnDividendSpec, then can test ClearAllDividends()

function OnDividendSpec(spec)
	
	print("OnDividend happen")
	
	ProductDividend =spec:FindProductDividend("SIM.F.NK.OCT2013");
	
	ProductDividend:ClearAllDividends();
	spec:InsertProductDividend(ProductDividend); 
	ParameterManager:SetDividendSpec(spec);
			
end  
--]]
--[[
-- the following is for ClearAllProducts()

function OnDividendSpec(spec)
	print("OnDividend happen")
	spec:ClearAllProducts();
	ParameterManager:SetDividendSpec(spec);

end
--]]

function OnStop()
	ParameterManager:UnsubscribeParameter(spec_name, QS_DIVIDEND_SPEC, false, "DividendSpecification.lua" );
    --ParameterManager:UnsubscribeParameter(spec_name, QS_DIVIDEND_SPEC, true, "stateless.lua" );
end
