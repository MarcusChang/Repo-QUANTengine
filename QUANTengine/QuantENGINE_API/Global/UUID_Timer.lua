

function OnStart()
	NormalTimer()
	Sleep(1000)
	UUIDTimer()
end


function OnStop()

end

function OnTimer(id)
	if id ~= nil then
		print("id = "..id)
	end
end


function NormalTimer()
	Timer(5000, "UUID_Timer.lua", true, "TimerID1")
	Timer(2000, "UUID_Timer.lua", true, "TimerID2")
	
	ResetTimer("TimerID2", 6000)
		
	StopTimer("TimerID2")
	
			
end

--the UUIDTimer is a timer that will only be triggered once which means the timer will be stopped and time id will be abandon after it been triggered.
function UUIDTimer() 
	UUID = Timer(3000, "UUID_Timer.lua", true, "")
	print(UUID)	

	ResetTimer(UUID, 5000)
	
	StopTimer(UUID)
	
end
	