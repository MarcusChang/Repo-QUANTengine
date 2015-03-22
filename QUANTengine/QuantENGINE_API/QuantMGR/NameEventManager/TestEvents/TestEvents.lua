require "TestEventsData"
require "TestUtilities"

local QuantCORE = QuantCORE()
local NamedEventManager = QuantCORE:NamedEventManager()
local ExpectedCallback = ""
local ActualCallback = ""
local ActualCacheKey = "[NO_DATA]"
local ActualKey = "[NO_DATA]"
local ActualData = "[NO_DATA]"

local Filename = "TestEvents.lua"

function OnStart()
  local TestSelect = Util:LoadVarNumber("TestSelect")
  print("TestSelect "..TestSelect)
  local TestData = GetEventTestData(TestSelect);
 
  local description = ""
  description = description.."Test function NamedEventManager:AddEvent("
  if type(TestData.CacheKey) == "string" then
    description = description.."\""..tostring(TestData.CacheKey).."\", "
  else
    description = description..tostring(TestData.CacheKey)..", "
  end
  
  if type(TestData.Key) == "string" then
    description = description.."\""..tostring(TestData.Key).."\", "
  else
    description = description..tostring(TestData.Key)..", "
  end
 
  if type(TestData.Data) == "table" then
    description = description.."{"
    
    local count = 1
    for key, value in pairs(TestData.Data) do
      if count > 1 then
        description = description.." ,"
      end
      
      if type(key) == "number" then
        description = description.."[\""..key.."\"] = "
        
      else
        description = description.."["..key.."] = "
        
      end
      
      if type(value) == "string" then
        description = description.."\""..value.."\""
        
      else
        description = description..value
        
      end
      
      count = count + 1
    end
    description = description.." }"
  else
    if type(TestData.Data) == "string" then
      description = description.."\""..tostring(TestData.Data).."\""
    else
      description = description..tostring(TestData.Data)
    end
  end
  
  description = description ..")"
  
  print("data ="..tostring(description))
  
  LogTestInfo(Filename, TestSelect, description)
  
  if ((type(TestData.CacheKey) == "string" and TestData.CacheKey ~= "") or type(TestData.CacheKey) == "number")
      and ((type(TestData.Key) == "string" and TestData.Key ~= "") or type(TestData.Key) == "number") then
      print("type(TestData.Stateless) = "..type(TestData.Stateless))
      print("TestData.Stateless = "..tostring(TestData.Stateless))
     
     NamedEventManager:AddListener(TestData.CacheKey, TestData.Key, TestData.Username, TestData.Stateless, "TestEvents.lua")
  end
  
  NamedEventManager:AddEvent(TestData.CacheKey, TestData.Key, TestData.Data)
  
  if TestData.ExpectedLevel ~= "FAT" then
    Timer(1, 1000, Filename)
  else
    LogTestResult(Filename, TestSelect, "Check that no code is run after running code which should trigger a FAT level error", false, true)
    
    SendCompletionCode(0, "Complete") 
  end
  
  NamedEventManager:RemoveEvent(TestData.CacheKey, TestData.Key)
  
  if TestData.ExpectedLevel ~= "FAT" then
    Timer(1, 1000, Filename)
  else
    LogTestResult(Filename, TestSelect, "Check that no code is run after running code which should trigger a FAT level error", false, true)
    
    SendCompletionCode(0, "Complete") 
  end
  
end

function OnTimer(id)
  local TestSelect = Util:LoadVarNumber("TestSelect")
  local TestData = GetEventTestData(TestSelect);
  
  LogTestResult(Filename,TestSelect,"Check the Cache Key added to the cache is correct", tostring(TestData.CacheKey), ActualCacheKey)
  
  -- If the type of the cache key is not a string, then check it is converted to a string
  if type(TestData.CacheKey) ~= "string" then
    LogTestResult(Filename,TestSelect,"Check the type of the Cache Key added to the cache has been converted to string", "string", type(ActualCacheKey))
  end
  
  LogTestResult(Filename,TestSelect,"Check the Key added to the cache is correct", tostring(TestData.Key), ActualKey)
  
  -- If the type of the key is not a string, then check it is converted to a string
  if type(TestData.Key) ~= "string" then
    LogTestResult(Filename,TestSelect,"Check the type of the Key added to the cache has been converted to string", "string", type(ActualKey))
  end
  
  LogTestResult(Filename,TestSelect,"Check the Username added to the cache is correct",TestData.Username,ActualUsername)
 
  if type(TestData.Data) == "table" then
    for k in pairs(TestData.Data) do
      if type(k) == "string" then
        LogTestResult(Filename, TestSelect,"Check the TestData.Data[\""..k.."\"] = ActualData[\""..k.."\"]",TestData.Data[k],ActualData[k])
      else
        LogTestResult(Filename, TestSelect,"Check the TestData.Data["..k.."] = ActualData["..k.."]",TestData.Data[k],ActualData[k])
      end
    end
  else
    LogTestResult(Filename, TestSelect, "Check the Data added to the cache is correct", TestData.Data, ActualData)
  end
  
  LogTestResult(Filename, TestSelect, "Check the type of the Data added to the cache is correct", type(TestData.Data), type(ActualData))
  
  SendCompletionCode(0, "Complete")
end

function OnStop()

end

function OnEvent(cacheKey, Key, Username, data)
  for key, value in pairs(data) do
  	print("OnEvent_data-key ="..tostring(key))
  	print("OnEvent_data-value ="..tostring(value))
  end 
  ActualCallback = "OnEvent"
  print("OnEvent cacheKey = "..tostring(cacheKey))
  print("OnEvent Key = "..tostring(Key))
  print("OnEvent data = "..tostring(data)) 
  ActualCacheKey = cacheKey
  ActualKey = Key
  ActualUsername = Username
  ActualData = data
end

function OnEventNotify(cacheKey, Key, Username)
  ActualCallback = "OnEventNotify"
  print("OnEventNotify cacheKey = "..cacheKey)
  print("OnEventNotify Key = "..Key)
  print("OnEventNotify Username = "..Username)
  
  local data = NamedEventManager:GetEvent(cacheKey, Key, Username)
  
  print("OnEventNotify data = "..tostring(data))
  
  ActualCacheKey = cacheKey
  ActualKey = Key
  ActualUsername = Username
  ActualData = data
end

function OnRemoveEvent(cacheKey, Key, Username, data)
   for key, value in pairs(data) do
  	print("OnRemoveEvent_data-key ="..tostring(key))
  	print("OnRemoveEvent_data-value ="..tostring(value))
  end  
  ActualCallback = "OnRemoveEvent"
  print("OnRemoveEvent cacheKey = "..tostring(cacheKey))
  print("OnRemoveEvent Key = "..tostring(Key))
  print("OnRemoveEvent data = "..tostring(data))
  ActualCacheKey = cacheKey
  ActualKey = Key
  ActualUsername = Username
  ActualData = data
end

function OnRemoveEventNotify(cacheKey, Key, Username)
  ActualCallback = "OnRemoveEventNotify"
  print("OnRemoveEventNotify cacheKey = "..cacheKey)
  print("OnRemoveEventNotify Key = "..Key)
  print("OnRemoveEventNotify Username = "..Username)
  
  local data = NamedEventManager:GetEvent(cacheKey, Key, Username)
  
  print("OnRemoveEventNotify data = "..tostring(data))
  
  ActualCacheKey = cacheKey
  ActualKey = Key
  ActualUsername = Username
  ActualData = data
end
