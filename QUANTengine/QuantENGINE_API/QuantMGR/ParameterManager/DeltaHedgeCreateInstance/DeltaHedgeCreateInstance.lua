require "statefull"
require "stateless"
local QuantCORE = QuantCORE();
local ParameterManager = QuantCORE:ParameterManager();
local spec_name = nil;

function OnStart()
ParameterManager:SubscribeParameter(spec_name, QS_DELTA_HEDGE_SPEC, false, "statefull.lua" );
--ParameterManager:SubscribeParameter(spec_name, QS_DELTA_HEDGE_SPEC, true, "stateless.lua" );
end

function OnStop()

end