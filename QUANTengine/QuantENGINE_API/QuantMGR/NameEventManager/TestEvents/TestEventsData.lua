require "TestUtilities"
local QuantCORE = QuantCORE();
local NamedEventManager = QuantCORE:NamedEventManager();
Callback = "TestEvents.lua"

local COL_TEST_CASE = 1
local COL_FUNCTION_NAME = 2
local COL_CACHE_KEY = 3
local COL_KEY = 4
local COL_DATA = 5
local COL_STATELESS = 6
local COL_EXPECTED_LEVEL = 7
local COL_EXPECTED = 8
local COL_ACTIVE = 9
local SEP = "\t"
local Username = "Marcus_Chang"


function GetEventTestData(TestCase)
  local Filename = Util:LoadVarString("TestFileName")
  local file = io.open(Filename,"r")
  local i = 1;
  for line in file:lines() do
    line = string.gsub(line, "\"", "")
    if TestCase == tonumber(GetNthField(line, SEP, COL_TEST_CASE)) then
      EventTestData = {};
      EventTestData.FunctionName = "NamedEventManager:AddEvent"
      EventTestData.Function = NamedEventManager.AddEvent
      EventTestData.FunctionManager = NamedEventManager;
      EventTestData.CacheKey = GetTestDataField(GetNthField(line, SEP, COL_CACHE_KEY))
      EventTestData.Key = GetTestDataField(GetNthField(line, SEP, COL_KEY))
      EventTestData.Username = Username
      EventTestData.Data = GetTestDataField(GetNthField(line, SEP, COL_DATA))
      EventTestData.Stateless = GetTestDataField(GetNthField(line, SEP, COL_STATELESS))
      EventTestData.ExpectedLevel = GetNthField(line, SEP, COL_EXPECTED_LEVEL)
      EventTestData.ExpectedResult = GetNthField(line, SEP, COL_EXPECTED)
      EventTestData.Active = GetNthField(line, SEP,  COL_ACTIVE)
      EventTestData.Step = tonumber(GetNthField(line, SEP, COL_TEST_CASE));
      return EventTestData;	
    end
  end
end