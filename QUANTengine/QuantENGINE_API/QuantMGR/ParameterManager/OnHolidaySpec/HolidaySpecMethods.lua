local QuantCORE = QuantCORE();
local ParameterManager = QuantCORE:ParameterManager();
local spec_name = "KOSPI_HOLIDAYS3";


function OnStart()
	print("OnStart -- Subcribe parameter");
    ParameterManager:SubscribeParameter(spec_name, QS_HOLIDAY_SPEC, false, "HolidaySpecMethods.lua" );
    --Timer(1, 1000, "HolidaySpecMethods.lua");
end


--[[function OnHolidaySpec(spec) 
    print("OnHolidaySpec");
    --print key in spec
    print("key="..spec:GetKey());
 	ParameterManager:SubscribeParameter("Holiday_CATHY",QS_HOLIDAY_SPEC,false,"HolidaySpecMethods.lua")
 	Holiday_CATHY=HolidaySpecification:CreateInstance();
    Holiday_CATHY:SetKey("Holiday_CATHY") ;
    ParameterManager:SetHolidaySpec(Holiday_CATHY);
    
end  --]]

--[[
function OnTimer(id)
    print("OnTimer -- Unsubscribe parameter");
    
    SendCompletionCode(0, "Complete");
end
--]]
-- the following is for testing ClearAllHolidays(), will clear all teh holidays in relative Holiday Spec

function OnHolidaySpec(spec) 
    print("OnHolidaySpec");
    spec:ClearAllHolidays();
    ParameterManager:SetHolidaySpec(spec)
end  




function OnStop()
	ParameterManager:UnsubscribeParameter(spec_name, QS_HOLIDAY_SPEC, false, "HolidaySpecMethods.lua" );
end