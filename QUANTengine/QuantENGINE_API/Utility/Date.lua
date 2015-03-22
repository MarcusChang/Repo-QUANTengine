local LoadString = Util:LoadVarString("Date_VarString");
local LoadNumber = Util:LoadVarNumber("Date_VarNumber");
local LoadCSV = Util:LoadFromFile(filePath, false);
--the filePath and SavePath is the absolute path of the csv files.
local filePath = "C:\Temp\";
local SavePath = "D:\Temp\";
 

function OnStart()

	print("LoadString -> "..tostring(LoadString));
	print("LoadNumber -> "..tostring(LoadNumber));
	
	if LoadCSV ~= nil then 
		for k, v in pairs(LoadCSV) do
			print("LoadCSV k ---> "..tostring(k));
			print("LoadCSV v ---> "..tostring(v));
		end
		
		local SaveFile = Util:SaveToFile(LoadCSV, SavePath)
		
		if SaveFile ~= nil then
			print("--------> The SaveFile success!");
		else
			print("--------> The SaveFile failed!");
		end	
		
	else
		print("--------------> The LoadCSV is nil");
	end	


	local date1 = Date:FromString("20111129");
	local date2 = Date:FromString("20120101");
	print ("date1:"..date1:AsString());
	print ("date1 year:"..date1:Year());
	print ("date1 month:"..date1:Month());
	print ("date1 day:"..date1:Day());
	local result=date1:CompareTo(date2);
	print ("result:"..result);
	if(result < 0) then
		print "date1 is earlier than date2";
	elseif(result == 0) then
		print "date1 is same with date2";
	else
		print "date1 is later than date2";
	end
	print("date2:"..date2:AsString());
	date2:SetDate(20,05,2000);
	print("date2:"..date2:AsString());
end

function OnStop()
	local LastMessage = Util:GetLastMessage("", "INF");
	print("-----------> LastMessage: "..tostring(LastMessage));
	Util:ClearLastMessage("");
	print("Project Stopped~!!!")
end