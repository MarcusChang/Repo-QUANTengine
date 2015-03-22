local QuantCORE = QuantCORE();
local ParameterManager = QuantCORE:ParameterManager();
local spec_name = "QA_XJOMOCK_UNDER";


function OnStart()
    print("OnStart -- Subcribe parameter");
    ParameterManager:SubscribeParameter(spec_name, QS_UNDERLYING_SPEC, false, "statefull.lua" );
 	--ParameterManager:SubscribeParameter(spec_name, QS_UNDERLYING_SPEC, true, "stateless.lua" );
    --Timer(1, 5000, "UnderlyingSpec2.lua");
end
--[[
function OnTimer(id)
    print("OnTimer -- Unsubscribe parameter");
    SendCompletionCode(0, "Complete");
end
--]]
function OnStop()
	ParameterManager:UnsubscribeParameter(spec_name, QS_UNDERLYING_SPEC, false, "statefull.lua" );
	--ParameterManager:UnsubscribeParameter(spec_name, QS_UNDERLYING_SPEC, true, "stateless.lua" );
end