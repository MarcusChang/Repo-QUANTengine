
local r = QuantCORE()
local nem = r:NamedEventManager()

local ck0 = "Something0"
local k0 = "something_else0"

--[[
local ck1 = "Something1"
local k1 = "something_else1"
--]]

local ck1 = 55
local k1 = 66

local ck2 = "Something2"
local k2 = "something_else2"



local ck3 = "Something3"
local k3 = "something_else3"

local ck4 = "Something4"
local k4 = "something_else4"

local ck5 = "Something5"
local k5 = "something_else5"


function OnStart()

	nem:AddListener(ck0, k0, "", false, "NEM_GetEventGroup.lua")
	Sleep(1000)	
	nem:AddListener(ck1, k1, "", false, "NEM_GetEventGroup.lua")
	Sleep(1000)
	nem:AddListener(ck2, k2, "", false, "NEM_GetEventGroup.lua")
	Sleep(1000)
	nem:AddListener(ck3, k3, "", false, "NEM_GetEventGroup.lua")
	Sleep(1000)
	nem:AddListener(ck4, k4, "", false, "NEM_GetEventGroup.lua")
	Sleep(1000)
	nem:AddListener(ck5, k5, "", false, "NEM_GetEventGroup.lua")
	Sleep(1000)
	

	
	
		--nem:AddListener(ck0, k0, "", false, "NEM_GetEventGroup.lua")
	
	
	local t = { }
	for i=1, 10 do
		CreateElement(t, i - 1)
	end

	
	nem:AddEvent(ck0, k0, t)
	Sleep(1000)
	nem:AddEvent(ck1, k1, t)
	Sleep(1000)
	nem:AddEvent(ck2, k2, t)
	Sleep(1000)
	nem:AddEvent(ck3, k3, t)
	Sleep(1000)
	nem:AddEvent(ck4, k4, t)
	Sleep(1000)
	nem:AddEvent(ck5, k5, t)
	Sleep(1000)

--[[	
	for l = 1, 100 do
		nem:AddEvent(ck0, k0, t)
		Sleep(50)
	end	
--]]	
end

function CreateElement(t, i)
	
	if (t == nil) then 
		t = { }
	end
	
	t[i] = { }
	t[i].ID = i
end

function OnStop()
end

function OnEvent(ck, k, user, data)
	
	Sleep(1000)	
	print("[ERR] "..tostring(#data))
	
	for k,v in pairs(data) do
		
		print(tostring(k).."_"..tostring(v))
	
	end
	
	print(tostring(ck))
	local table = nem:GetEventGroup(ck, "")
	if (table == nil) then
		print("[ERR]the table is nil.")
	else
		for k,v in pairs(table) do
			print("[ERR] "..tostring(k).." - "..tostring(v))
		end
	end
end