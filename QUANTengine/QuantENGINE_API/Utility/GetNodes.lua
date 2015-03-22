function OnStart()
--justChildNodes = true
--[[
local table = Util:GetChildNodes("SIM.O.>", true)
if (table ~= nil) then
    for series, isLeafNode in pairs(table) do
        local hasChildren = not(isLeafNode)
        print("SERIES:"..tostring(series)..", HasChildren:"..tostring(hasChildren), LOG_DEB)
    end
end
--]]


local table1 = Util:GetChildNodes("SIM.O.XJO.>", false)
if (table1 ~= nil) then
    for childProductPath, isLeafNode in pairs(table1) do
        local hasChildren = not(isLeafNode)
        print("CHILD ProductPath:"..tostring(childProductPath)..", HasChildren:"..tostring(hasChildren), LOG_DEB)
    end
end


 
-- The output should be:
-- SERIES:MAR2013, HasChildren:true
-- ...
-- SERIES:STRATEGIES, HasChildren:true

end

function OnStop()
--[[
--justChildNodes = false

local table1 = Util:GetChildNodes("SIM.O.>", false)
if (table1 ~= nil) then
    for childProductPath, isLeafNode in pairs(table1) do
        local hasChildren = not(isLeafNode)
        print("CHILD ProductPath:"..tostring(childProductPath)..", HasChildren:"..tostring(hasChildren), LOG_DEB)
    end
end
--]]

local table = Util:GetChildNodes("SIM.O.XJO.>", true)
if (table ~= nil) then
    for series, isLeafNode in pairs(table) do
        local hasChildren = not(isLeafNode)
        print("SERIES:"..tostring(series)..", HasChildren:"..tostring(hasChildren), LOG_DEB)
    end
end

-- The output should be:
-- CHILD ProductPath:SIM.O.NK.MAY2013.7000.C.0, HasChildren:false
-- ...

end
