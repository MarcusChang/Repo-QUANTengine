
local QuantCORE = QuantCORE();
local AttManager = QuantCORE:AttManager();
local ProductPath="SIM.F.XJO.DEC2012";
local MachineSpec="MARCUS_XJO_MQ5";

local TakeoutLimitUpdate = nil;
local TakeoutEdgeUpdate = nil;

local timer_Id=100;
local timer_Interval=1000;

function OnStart()

AttManager:SubscribeAtt( MachineSpec, false, "GlobalLimitAttd.lua" );
Timer(timer_Id,timer_Interval,"GlobalLimitAttd.lua");
end

function OnStop()
AttManager:UnsubscribeAtt( MachineSpec, false, "GlobalLimitAttd.lua" );
StopTimer(timer_Id);
end

function OnTimer( id )
	TakeoutLimitUpdate = AttManager:CreateLimitUpdate( MachineSpec );
	TakeoutEdgeUpdate = AttManager:CreateEdgeUpdate( MachineSpec );
	
	if( TakeoutLimitUpdate ~= nil ) then
		AttManager:SendLimitUpdate( MachineSpec, TakeoutLimitUpdate );
	end
	
    if( TakeoutEdgeUpdate ~= nil ) then
		AttManager:SendEdgeUpdate( MachineSpec, TakeoutEdgeUpdate );
	end

end

function OnATTLimitUpdate(takeoutBroadcast )
print("OnATTLimitUpdate");
end

function OnATTHeartbeat( heartbeat )
  print("OnATTHeartbeat");
end