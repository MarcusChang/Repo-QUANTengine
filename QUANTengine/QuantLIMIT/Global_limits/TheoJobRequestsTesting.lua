local theoManager = QuantCORE():TheoManager();

--local productPath = Util:LoadVarString("ProductPath");
--local pricingSpec = Util:LoadVarString("PricingSpec");

--local timer_ID = Util:LoadVarNumber("TimeID");
--local timer_Interval = Util:LoadVarNumber("TimeInterval");

local productPath="SIM.F.XJO.DEC2012";
local pricingSpec="QA_XJO"
local timer_ID = 100;
local timer_Interval = 1000;
local actionID = 0;
local price = 900;

function OnStart()
    modifier = theoManager:BuildTheoReferenceModifier(); 
    
	theoManager:SubscribeTheo(productPath , pricingSpec, false, "TheoJobRequestsTesting.lua");

	modifier:Underlying(price);
	
	print ("modifer:Underlying(price)is "..modifier:Underlying());	
	
	Timer(timer_ID,timer_Interval,"TheoJobRequestsTesting.lua");
end


function OnTheo( theo )
	if theo ~= nil then
		print("Product Path: "..theo:ProductPath());
		print("Product Name: "..theo:ProductName());
		print("Theo Price: "..theo:TheoPrice());
		print("Delta: "..theo:Delta());
		print("Underlying Price: "..theo:UnderlyingPrice());
		
		
	end
end

function OnTimer( id )
theoManager:RunTheoJob("QA_XJO", modifier);
modifier:Underlying(price+1);

if theoManager:RunTheoJob( pricingSpec, modifier ) == false then
		SendCompletionCode(QS_COMPLETION_CODE_ABORTED, "Run theo job failed!");
	end
theoManager:ResetTheos("QA_XJO");

end


function OnStop()
	theoManager:UnsubscribeTheo( productPath, pricingSpec, false, "TheoJobRequestsTesting.lua");
	
	StopTimer(timer_ID);
	
end