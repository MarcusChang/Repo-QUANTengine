quantCore = QuantCORE();
NEM = quantCore:NamedEventManager();

function OnStart()
    group = "group";
    -- AddListener: Register a listener to NEM, so script can get notification of named event changes specified
    --         by user name, group name and key name
    -- Param cacheKey: Group name. One user can have many groups distinguished by their group names. Empty group
    --         name means listening to changes of all groups of given user.
    -- Param key: Key name, support wildcard. One group can have many keys distinguished by their key names. Empty
    --        key name means listening to changes of all keys of given group.
    -- Param userName: User name, empty means current user, otherwise it should be in the same user group of current user.
    -- Param stateless: True for stateless script callback, false for stateful
    -- Param callback: Callback script in which OnEvent, OnEventNotify, OnRemoveEvent and OnRemoveEventNotify will be called.
    --        Callback should be script file name. Empty string unsupported.
    -- NOTE1: Stateless and stateful listener could be added to the same callback at the same time.
    NEM:AddListener(group, "SIM.O.XJO.JUN2013.>", "JIM", false, "Listener.lua");
    NEM:AddListener(group, "SIM.O.XJO.JUN2013.>", "", true, "Listener.lua");
    
    -- These actions will trigger OnEvent
    NEM:AddEvent(group, "SIM.O.XJO.JUN2013.>", "Value in node SIM.O.XJO.JUN2013.>");    
    NEM:AddEvent(group, "SIM.O.XJO.JUN2013.4650.>", "Value in node SIM.O.XJO.JUN2013.4650.>");
    
    -- These actions won't trigger OnEvent, but the second one will trigger OnEventNotify
    NEM:AddEvent(group, "SIM.O.XJO.>", "Value in node SIM.O.NK.>");
    NEM:AddEvent(group, "SIM.O.XJO.JUN2013.4650.C.0", "Value in leaf SIM.O.XJO.JUN2013.4650.C.0");
    
    -- This action will trigger OnRemoveEvent
    NEM:RemoveEvent(group, "SIM.O.XJO.JUN2013.4650.>");    
end

function OnStop()
    -- RemoveListener: Unregister a listener to the notification of named event changes.
    -- Param cacheKey: Group name. One user can have many groups distinguished by their group names. Empty group
    --         name means listening to changes of all groups of given user.
    -- Param key: Key name, support wildcard. One group can have many keys distinguished by their key names. Empty
    --        ken name means listening to changes of all keys of given group.
    -- Param userName: User name, empty means current user, otherwise it should be in the same user group of current user.
    -- Param stateless: True for stateless script callback, false for stateful
    -- Param callback: Callback script in which OnEvent, OnEventNotify, OnRemoveEvent and OnRemoveEventNotify will be called.
    --        Callback should be script file name. Empty string unsupported.
    -- NOTE1: If listeners are not explicitly removed by RemoveListener, they'll be removed implicitly when current project stops.
    -- NOTE2: Remove unregistered listener will cause fatal error.
    NEM:RemoveListener("group", "SIM.O.XJO.JUN2013.>", "JIM", false, "Listener.lua");
end

-- OnEvent: Callback function notifying event value updated in given user name, group name and key node
-- Param cacheKey: Group name.
-- Param key: Key name. Could be wildcard.
-- Param userName: User name.
-- Param data: Value in given named event
function OnEvent(cacheKey, key, userName, data)
    print("Updating.........................")
    print(key)
    print(data)
end

-- OnRemoveEvent: Callback function notifying event value removed in given user name, group name and key node
-- Param cacheKey: Group name.
-- Param key: Key name. Could be wildcard.
-- Param userName: User name.
-- Param data: Value in given named event
function OnRemoveEvent(cacheKey, key, userName, data)
    print("Removing.........................")
    print(key)
    print(data)
    
    --NOTE: Value already removed, trying to get it will cause warning
    NEM:GetEvent(group, key, userName);
end

-- OnEventNotify: Callback function notifying event value updated in given user name, group name and key node.
--        Once be triggered won't be called until user explicitly calls GetEvent or GetEvents for corresponding
--        user name, group name and key node.
-- Param cacheKey: Group name.
-- Param key: Key name. Could be wildcard.
-- Param userName: User name.
function OnEventNotify(cacheKey, key, userName)
    print("Notifying.........................")
    print(key)
    data = NEM:GetEvent(group, key, userName);
    print(data)
    
    -- This action will trigger OnRemoveEventNotify
    NEM:RemoveEvent(group, "SIM.O.XJO.JUN2013.4650.C.0");
end

-- OnEventNotify: Callback function notifying event value updated in given user name, group name and key node.
--        Once be triggered won't be called anymore.
-- Param cacheKey: Group name.
-- Param key: Key name. Could be wildcard.
-- Param userName: User name.
function OnRemoveEventNotify(cacheKey, key, userName)
    print("Notifying removing.................")
    print(key)
    data = NEM:GetEvent(group, key, userName);
    
    -- This action will trigger OnEventNotify
    NEM:AddEvent(group, "SIM.O.XJO.JUN2013.4650.C.0", "Value in leaf SIM.O.XJO.JUN2013.4650.C.0");
    
    -- But this action won't trigger OnRemoveEventNotify anymore
    NEM:RemoveEvent(group, "SIM.O.XJO.JUN2013.4650.C.0");
end