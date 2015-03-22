local QuantCORE = QuantCORE();
local ParameterManager = QuantCORE:ParameterManager()
local spec_name = "QA_QuantSIM_R5"

local firstTime = true; 
local count=0 ; 


function OnStart()
ParameterManager:SubscribeParameter(spec_name, QS_DELTA_HEDGE_SPEC, false, "" );
end


function OnDeltaHedgeSpec(spec)
	
	if firstTime == true and spec:GetKey() == spec_name and count<5 then
	print("OnDeltaHedgeSpec");
	print("key="..spec:GetKey());
	local Series = rsDeltaHedgeSpecification:CreateInstance() 
	Series:AddProduct("SIM.O.APPLES.>");
	Series:SetKey(spec_name)
	ParameterManager:SetDeltaHedgeSpec(Series);
	count = count+1
	--firstTime = false;
	end
	
end



function OnStop()

end