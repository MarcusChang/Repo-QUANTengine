function LogTestResult(filename,step,description,expected,actual)
  local Filename = Util:LoadVarString("ResultsFileName")
  local file = io.open(Filename,"a")
  file:write("<item>\n")
  file:write("   <time>"..tostring(os.date("%d/%m/%Y %X")).."</time>\n")
  file:write("   <type>Test</type>\n")
  file:write("   <filename>"..tostring(filename).."</filename>\n")
  file:write("   <step>"..tostring(step).."</step>\n")
  file:write("   <description>"..tostring(description).."</description>\n")
  file:write("   <expected>"..tostring(expected).."</expected>\n")
  file:write("   <actual>"..tostring(actual).."</actual>\n")
  
  
  if type(expected) == type(actual) then
    if expected == actual then
      file:write("   <result>Pass</result>\n")
      UpdateStats(1, 1, 0)
    else
      file:write("   <result>Fail</result>\n")
      UpdateStats(1, 0, 1)
    end
    file:write("   <comment></comment>\n")
  else
    file:write("   <result>Fail</result>\n")
    file:write("   <comment>Type mismatch between expected result and actual result</comment>\n")
    UpdateStats(1, 0, 1)
  end
  
  file:write("</item>\n");
  file:close();
end

function UpdateStats(diffTotal, diffPassed, diffFailed)
  local StatsFileName = Util:LoadVarString("StatsFileName")
  local file = io.open(StatsFileName,"r")
  local line = file:read("*line")
  local total = tonumber(GetNthField(line, ",", 1))
  local passed = tonumber(GetNthField(line, ",", 2))
  local failed = tonumber(GetNthField(line, ",", 3))
  file:close();
  
  file = io.open(StatsFileName,"w")
  local updatestats = total+diffTotal..","..passed+diffPassed..","..failed+diffFailed
  file:write(updatestats)
  file:close();
end

function LogTestPattern(filename,step,description,pattern,actual)
  local Filename = Util:LoadVarString("ResultsFileName")
  local file = io.open(Filename,"a")
  file:write("<item>\n")
  file:write("   <time>"..tostring(os.date("%d/%m/%Y %X")).."</time>\n")
  file:write("   <type>Test</type>\n")
  file:write("   <filename>"..tostring(filename).."</filename>\n")
  file:write("   <step>"..tostring(step).."</step>\n")
  file:write("   <description>"..tostring(description).."</description>\n")
  file:write("   <expected>"..tostring(pattern).."</expected>\n")
  file:write("   <actual>"..tostring(actual).."</actual>\n")
  
  if type(pattern) == "string" and type(actual) == "string" then
    if type(string.match(actual, pattern)) == "string" then
      file:write("   <result>Pass</result>\n")
      UpdateStats(1, 1, 0)
    else
      file:write("   <result>Fail</result>\n")
      UpdateStats(1, 0, 1)
    end
    file:write("   <comment></comment>\n")
  else
    file:write("   <result>Fail</result>\n")
    UpdateStats(1, 0, 1)
    file:write("   <comment>Type mismatch between expected result and actual result</comment>\n")
  end
  
  file:write("</item>\n");
  file:close();  
end

function LogTestInfo(filename,step,description)
  local Filename = Util:LoadVarString("ResultsFileName")
  local file = io.open(Filename,"a")
  file:write("<item>\n")
  file:write("   <time>"..tostring(os.date("%d/%m/%Y %X")).."</time>\n")
  file:write("   <type>Info</type>\n")
  file:write("   <filename>"..tostring(filename).."</filename>\n")
  file:write("   <step>"..tostring(step).."</step>\n")
  file:write("   <description>"..tostring(description).."</description>\n")
  file:write("   <expected></expected>\n")
  file:write("   <actual></actual>\n")
  file:write("   <result></result>\n")
  file:write("   <comment></comment>\n")  
  file:write("</item>\n");
  file:close();
end

function GetLogSubstring(original,startPattern,endPattern)
  local i, j
  
  i,j = string.find(original, startPattern)
  
  i = string.find(original,endPattern,j)
  
  return string.sub(original,j+1,i-1)
end

function TestCall()
   print("hello")
end

-- Gets the nth field from a string separated by the character
function GetNthField(list, separator, n)
  list = list..separator
  local fieldstart = 1
  local countfields = 1;
  repeat
    local nexti = string.find(list, separator, fieldstart)
    
    if countfields == n then
      return string.sub(list, fieldstart, nexti-1)
    end

    fieldstart = nexti + 1
    countfields = countfields + 1
  until fieldstart > string.len(list)
end

function GetFieldCount(list, separator)
  list = list..separator
  local fieldstart = 1
  local countfields = 1;
  repeat
    local nexti = string.find(list, separator, fieldstart)
  
    fieldstart = nexti + 1
    countfields = countfields + 1    
  until fieldstart > string.len(list)
  return countfields - 1
end

function GetTestDataField(value)
 local result, returnvalue
  if type(value) == "string" then
    if string.match(value, "^%[STR%].*") then
      _, _, _, returnvalue = string.find(value, "^(%[STR%])(.*)")
      
    elseif string.match(value, "^%[NUM%].*") then
      _, _, _, result = string.find(value, "^(%[NUM%])(.*)")
      
      returnvalue = tonumber(result)
    elseif string.match(value, "^%[TRUE%]$") then
      returnvalue = true
    elseif string.match(value, "^%[FALSE%]$") then
      returnvalue = false
    elseif string.match(value, "^%[FUNCTION%]$") then
      returnvalue = function () end
    elseif string.match(value, "^%[TABLE%].*") then
      _, _, _, result = string.find(value, "^(%[TABLE%])(.*)")

      local i, key, value, row
      local mytable = {}
      
      for i = 1, GetFieldCount(result, ",") do
        row = GetNthField(result, ",", i)
        key = GetTestDataField(GetNthField(row, "=", 1))
        value = GetTestDataField(GetNthField(row, "=", 2))
        mytable[key] = value
      end
      returnvalue = mytable
    end
  else
    returnvalue = nil
  end
  return returnvalue
end

function RsOrderDescription(rsOrderTypeEnum)
  if rsOrderTypeEnum == QS_GFD then return "QS_GFD"
  elseif rsOrderTypeEnum == QS_AC then return "QS_AC"
  elseif rsOrderTypeEnum == QS_AS_GFD then return "QS_AS_GFD"
  elseif rsOrderTypeEnum == QS_AS_IOC then return "QS_AS_IOC"
  elseif rsOrderTypeEnum == QS_ASC then return "QS_ASC"
  elseif rsOrderTypeEnum == QS_IOC then return "QS_IOC"
  elseif rsOrderTypeEnum == QS_OPEN then return "QS_OPEN"
  elseif rsOrderTypeEnum == QS_ICE_CLOSE then return "QS_ICE_CLOSE"
  elseif rsOrderTypeEnum == QS_PRE_HEDGE then return "QS_PRE_HEDGE"
  elseif rsOrderTypeEnum == QS_SL then return "QS_SL"
  elseif rsOrderTypeEnum == QS_OPG then return "QS_OPG"
  elseif rsOrderTypeEnum == nil then return "nil"
  end
end

function UpdateTypeDescription(UpdateType)
  if UpdateType == QS_PUBLIC_UPDATE then return "QS_PUBLIC_UPDATE"
  elseif UpdateType == QS_PRIVATE_MODIFIED_UPDATE then return "QS_PRIVATE_MODIFIED_UPDATE"
  elseif UpdateType == QS_PRIVATE_UNMODIFIED_REFRESH then return "QS_PRIVATE_UNMODIFIED_REFRESH"
  elseif UpdateType == QS_PUBLIC_END_OF_DAY_UPDATE then return "QS_PUBLIC_END_OF_DAY_UPDATE"
  elseif UpdateType == nil then return "nil"
  else return UpdateType
  end
end

function SignalTypeDescription(SignalType)
  if SignalType == QS_DOUBLE_SIGNAL then return "QS_DOUBLE_SIGNAL"
  elseif SignalType == QS_STRING_SIGNAL then return "QS_STRING_SIGNAL"
  elseif SignalType == nil then return "nil"
  else return SignalType
  end
end