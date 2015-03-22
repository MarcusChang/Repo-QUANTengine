--[[
Callback.lua: implement all the required Callback functions
--]]


--Callback fucntion for Signal/NamedEvent( Stateful )
function OnEventNotify( groupKey, key, data )
    if( groupKey ~= "signalingCase01" ) then
		print("Error group key!");
		return;
	end
	--Get the Signal message
	print( "The signal: key: " .. tostring( key ) .. " value: " .. tostring(data) );
end