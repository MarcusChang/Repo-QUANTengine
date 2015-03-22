local QuantCORE = QuantCORE();
local ParameterManager = QuantCORE:ParameterManager();
local spec_name = "KOSPI_HOLIDAYS3";


function OnStart()
print("OnStart -- Subcribe parameter");
    ParameterManager:SubscribeParameter(spec_name, QS_HOLIDAY_SPEC, false, "HolidaySpecUpdate.lua" );
    --Timer(1, 1000, "");
end


function OnTimer(id)
    print("OnTimer -- Unsubscribe parameter");
    ParameterManager:UnsubscribeParameter(spec_name, QS_HOLIDAY_SPEC, false, "HolidaySpecUpdate.lua" );
    SendCompletionCode(0, "Complete");
end

function OnHolidaySpec(spec) 
    print("OnHolidaySpec");
    --print key in spec
    print("key="..spec:GetKey());
 
 local      FoundHoliday = spec:FindHoliday(Date:FromString("20130416")) 
--   local      FoundHoliday = spec:FindHoliday(Date:FromString(nil)) 
				if FoundHoliday ==false then 
                 print("Holiday not found from HolidaySpec");    
                 else
                 print("Holiday found successfully from HolidaySpec"); 	
                 end
  
  local newHoliday = spec:InsertHoliday( Date:FromString("20130620"));
--  local newHoliday = spec:InsertHoliday( Date:FromString(nil));
  if newHoliday == true then 
                 print("New Holiday inserted successfully in HolidaySpec");    
                 else
                 print("New Holiday not inserted in HolidaySpec"); 	
                 end 

	spec:RemoveHoliday( Date:FromString("20130210"));
--	spec:RemoveHoliday( Date:FromString(nil));
	--spec:ClearAllHolidays();
	
    ParameterManager:SetHolidaySpec(spec);
    local holidays = spec:GetHolidays();
    if holidays == nil then
        print("No holiday get from HolidaySpecification");
    else
        print("Total number get from holiday specs is: "..#holidays);
        local index = 1;
        while ( index <= #holidays ) do
            local holiday = holidays[index];
            print("Holiday is: "..holiday:AsString());
            index = index + 1;
        end
    end
end


function OnStop()

end