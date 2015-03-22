local QuantCORE = QuantCORE();
local ParameterManager = QuantCORE:ParameterManager();
local spec_name = "QA_XJO_MAC1";


function OnStart()
    print("OnStart -- Subcribe parameter");
    --ParameterManager:SubscribeParameter(spec_name, QS_PRICING_SPEC, false, "stateful.lua" );
    ParameterManager:SubscribeParameter(spec_name, QS_PRICING_SPEC, true, "stateless.lua" );
    --Timer(1, 5000, "");
end
--[[
function OnTimer(id)
    print("OnTimer -- Unsubscribe parameter");
    
    SendCompletionCode(0, "Complete");
end
--]]
function OnStop()
	--ParameterManager:UnsubscribeParameter(spec_name, QS_PRICING_SPEC, false, "stateful.lua" );
    ParameterManager:UnsubscribeParameter(spec_name, QS_PRICING_SPEC, true, "stateless.lua" );
end