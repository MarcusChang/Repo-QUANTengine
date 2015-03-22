quantCore = QuantCORE();
NEM = quantCore:NamedEventManager();

function OnStart()
    group = "ADMIN";
    NEM:AddListener(group, "SIM.O.>", "MAC", false, "Signal.lua");
    
    -- EnableSignaling: Enable/Disable signaling. 
    -- Param bEnable: True to turn on and false to turn off
    NEM:EnableSignaling(true);
    
    -- SendSignal: Send one signal with one-dimensional string table or double table to quantCore. So any other named 
    --         event managers running in other scripts, projects, process or even other boxes will get the message
    -- Param cacheKey: Group name. One user can have many groups distinguished by their group names. No empty string.
    -- Param key: Key name, support wildcard but not empty string.
    -- Param type: QS_STRING_SIGNAL means string table or QS_DOUBLE_SIGNAL means double table
    -- Param table: Value of the specified node, should be string table or double table depending on param type.
    NEM:SendSignal(group, "SIM.O.>", QS_DOUBLE_SIGNAL, {2013, 6, 16});
    NEM:SendSignal(group, "SIM.O.>", QS_STRING_SIGNAL, {"string A", "string B", "string C"});
end

function OnStop()
	 --Turn off the Signal listening on the Group "signalingCase01"
	nameEventCache:EnableSignaling( false );

	--Unsubscribe the listener on the Group "signalingCase01" ( Stateful )
	nameEventCache:RemoveListener( group, "SIM.O.>", "MAC", false, "Signal.lua");

end



function OnEvent(cacheKey, key, userName, data)
    print(cacheKey)
    print(key)
    print(userName)
    for key, value in pairs(data) do 
        print("key: "..tostring(key));
        print("value: "..tostring(value));
    end
    
    -- Log fatal when input table doesn't fit input type
    NEM:SendSignal(group, "SIM.O.>", QS_STRING_SIGNAL, {"string", "true", "XJO"});
end


function OnEventNotify( cacheKey, key, userName )
    if( cacheKey ~= "signalingCase01" ) then
		print("Error group key!");
		return;
	end
	--Get the Signal message
	print( "The signal: key: " .. tostring( key ) .. " value: " .. tostring(userName) );
end