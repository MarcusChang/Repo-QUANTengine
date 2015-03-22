local QuantCORE = QuantCORE();
local ParameterManager = QuantCORE:ParameterManager();
local spec_name ="MarcusTesting_Fit";

function OnStart()
    print("OnStart -- Subcribe parameter");
    ParameterManager:SubscribeParameter(spec_name, QS_DIVIDEND_SPEC, false, "DividendCreateInstance.lua" );   
--    Timer(1, 5000, "DividendCreateInstance.lua");
    
end

--[[
function OnTimer(id)
    print("OnTimer -- Unsubscribe parameter");
    
    SendCompletionCode(0, "Complete");
end
--]]

function OnDividendSpec(spec, fromSnapshot)

	if fromSnapshot == true then
		print("-------fromSnapshot = true----------")
	else
		print("-------fromSnapshot = false---------")
	end
	
	print("OnDividend happen");
	
	ProductDividendObj =spec:FindProductDividend("SIM.F.XJO.SEP2013");
	
	if ProductDividendObj == nil then
		print("The ProductDividendObj is nil")
	end
	
	print("ProductDividend"..ProductDividendObj:GetProduct())
	
	
	newDividend = Dividend:CreateInstance();
	
	local NewDate=Date:FromString("20130416");
	local NewAmount= 2000
	newDividend:SetDate(NewDate)
	newDividend:SetAmount(NewAmount)
	
	
	
	ProductDividendObj:InsertDividend(newDividend)
	
    spec:InsertProductDividend(ProductDividendObj);
	ParameterManager:SetDividendSpec(spec);
	
	
	print("Key is"..spec:GetKey());
	
	local productDividendTable = spec:GetProducts();
		
	print("#productDividendTable is "..#productDividendTable)
		
	local productDividend = productDividendTable[1];
	
	local dividendTable = productDividend:GetDividends();
	
	print("Product="..productDividend:GetProduct());
	
	--print("#dividendTable is "..#dividendTable)
	
	local dividend = dividendTable[1]
		
	print("DividenDate is "..dividend:GetDate():AsString());
	print("DividendAmount is "..dividend:GetAmount());

end 




function OnStop()
	ParameterManager:UnsubscribeParameter(spec_name, QS_DIVIDEND_SPEC, false, "DividendCreateInstance.lua");
    --ParameterManager:UnsubscribeParameter(spec_name, QS_DIVIDEND_SPEC, true, "stateless.lua" );
end 
