quantCore = QuantCORE();
NEM = quantCore:NamedEventManager();

function OnStart()
    group = "group";
    NEM:AddListener(group, "SIM.O.>", "JIM", false, "Signal.lua");
    
    -- EnableSignaling: Enable/Disable signaling. 
    -- Param bEnable: True to turn on and false to turn off
    NEM:EnableSignaling(true);
    
    -- SendSignal: Send one signal with one-dimensional string table or double table to quantCore. So any other named 
    --         event managers running in other scripts, projects, process or even other boxes will get the message
    -- Param cacheKey: Group name. One user can have many groups distinguished by their group names. No empty string.
    -- Param key: Key name, support wildcard but not empty string.
    -- Param type: RS_STRING_SIGNAL means string table or RS_DOUBLE_SIGNAL means double table
    -- Param table: Value of the specified node, should be string table or double table depending on param type.
    NEM:SendSignal(group, "SIM.O.>", RS_DOUBLE_SIGNAL, {2013, 5, 16});
    NEM:SendSignal(group, "SIM.O.>", RS_STRING_SIGNAL, {"string A", "string B", "string C"});
end

function OnStop()

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
    NEM:SendSignal(group, "SIM.O.>", RS_STRING_SIGNAL, {"string", "true", "XJO"});
end