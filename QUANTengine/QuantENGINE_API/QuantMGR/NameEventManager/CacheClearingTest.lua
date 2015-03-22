
local QuantCORE = QuantCORE()
local NamedEventManager = QuantCORE:NamedEventManager()

local ck = "CACHE_CLEARED"
local k = "ITEMS"
local USERNAME = ""

function OnStart()

	math.randomseed(os.time())
	local r1 = math.random(1, 20)
	local r2 = math.random(1, 10)
	LOG("r1 = "..tostring(r1)..", r2 = "..tostring(r2), LOG_ERR)

	local found = false
	local data = NamedEventManager:GetEvent(ck, k, USERNAME)
	if (data ~= nil) then
		found = true
		for ki, vi in pairs(data) do
			for kj, vj in pairs(vi) do
				LOG(tostring(vj), LOG_ERR)
			end
		end
		LOG(" ^^^^ FROM CACHE ^^^^ ", LOG_ERR)
	else
		LOG("Didn't find anything in the cache.", LOG_ERR)
	end

	local t = { }
	
	for i=1, r1 do
		t[i] = { }
		for j=1, r2 do
			t[i][j] = "["..i.."]["..j.."] = Hello"		
		end
	end

	NamedEventManager:AddEvent(ck, k, t)
	
	if (found == false) then
		SendCompletionCode(QS_COMPLETION_CODE_SUCCESS, "Populated the cache.")
	else
		LOG("NOTE: No table data should be printed.", LOG_ERR)
	end
end

function OnStop()
end