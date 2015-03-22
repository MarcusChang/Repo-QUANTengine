quantCore = QuantCORE();
NEM = quantCore:NamedEventManager();

function OnStart()
    group = "group";
    -- AddEvent: Set value of the node specified by given group name and key name for current user.
    -- Param cacheKey: Group name. One user can have many groups distinguished by their group names. No empty string.
    -- Param key: Key name, support wildcard but not empty string.
    -- Param value: support number, boolean, string, table and nested table
    NEM:AddEvent(group, "string", "String Value");
    NEM:AddEvent(group, "boolean", true);
    NEM:AddEvent(group, "number", 3.1415926);
    NEM:AddEvent(group, "SIM.O.XJO.JUN2013.>", "Value in SIM.O.XJO.JUN2013.>");
    NEM:AddEvent(group, "SIM.O.XJO.>", "Value in SIM.O.XJO.>");
    
    table1 = {"String Value", false, 0.618} -- Simple table
    table2 = {true, table1, 1111}            -- Nested table
    NEM:AddEvent(group, "table1", table1);
    NEM:AddEvent(group, "table2", table2);
    
    -- GetEvent: Fetch value of the node specified by given user name, group name and key name
    -- Param cacheKey: Group name. One user can have many groups distinguished by their group names. No empty string.
    -- Param key: Key name, support wildcard but not empty string.
    -- Param userName: User name, empty means current user, otherwise it should be in the same user group of current user.
    result = NEM:GetEvent(group, "string", "MAC");
    print(result);
    
    result = NEM:GetEvent(group, "table1", "");
    for key, value in pairs(result) do 
        print("key: "..tostring(key));
        print("value: "..tostring(value));
    end
    
    result = NEM:GetEvent(group, "table2", "");
    for key, value in pairs(result) do 
        print("key: "..tostring(key));
        if type(value) == "table" then
            for i, v in pairs(value) do 
                print("Item: "..tostring(v));
            end
        else
            print("value: "..tostring(value));
        end
    end
    
    -- Log warning if there's no value in specified node.
    result = NEM:GetEvent(group, "none", "");
    
    -- GetEvents: Fetch key value pair from the node specified by given user name, group name and key name to all its subnodes.
    -- Param cacheKey: Group name. One user can have many groups distinguished by their group names. No empty string.
    -- Param key: Key name, support wildcard but not empty string.
    -- Param userName: User name, empty means current user, otherwise it should be in the same user group of current user.
    result = NEM:GetEvents(group, "SIM.O.XJO.>", "MAC");
    for key, value in pairs(result) do 
        print("key: "..tostring(key));
        print("value: "..tostring(value));
    end
    
    -- Compare with GetEvent which only return the value of specified node
    result = NEM:GetEvent(group, "SIM.O.XJO.>", "");
    print(result)
    
    -- GetEventGroup: Fetch key value pair of all subnodes specified by given user name and group name
    -- Param cacheKey: Group name. One user can have many groups distinguished by their group names. No empty string.
    -- Param userName: User name, empty means current user, otherwise it should be in the same user group of current user.
    result = NEM:GetEventGroup(group, "MAC");
    for key, value in pairs(result) do 
        print("key: "..tostring(key));
        print("value: "..tostring(value));
    end
    
    -- RemoveEvent: Remove value of the node specified by given group name and key name for current user.
    -- Param cacheKey: Group name. One user can have many groups distinguished by their group names. No empty string.
    -- Param key: Key name, support wildcard but not empty string.
    NEM:RemoveEvent(group, "SIM.O.XJO.>");
    result = NEM:GetEvent(group, "SIM.O.XJO.>", ""); -- Warning cuz the value was already removed
    
    -- RemoveEvents: Remove value of the node and all subnodes specified by given group name and key name for current user.
    -- Param cacheKey: Group name. One user can have many groups distinguished by their group names. No empty string.
    -- Param key: Key name, support wildcard but not empty string.
    NEM:RemoveEvents(group, "SIM.O.XJO.>");
    result = NEM:GetEvent(group, "SIM.O.XJO.JUN2013.>", ""); -- Warning cuz the value was already removed
end

function OnStop()

end