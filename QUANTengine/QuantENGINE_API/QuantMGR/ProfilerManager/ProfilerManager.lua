local QuantENGINE = QuantENGINE()
local profilerManager = QuantENGINE:ProfilerManager();
local profiler = profilerManager:CreateProfiler() 

function OnStart()

	print("---------> The interval between the Reset and Pause should be approximated to profiler:Elapsed on line 13<--------")
	profiler:Reset()
	for i = 1, 100, 1 do
		Sleep(10)
	end 
	profiler:Pause()
	print("profiler:Pause() log timestamp -->"..profiler:Elapsed())

-----------------------------------------------------

	print("--------->Begin to start the count<--------")
	profiler:Restart()
	for i = 1, 100, 1 do
		Sleep(1)
	end 
	local Elapsed_1 = profiler:Elapsed()
	print("Elapsed_1 ="..tostring(Elapsed_1))

	
-----------------------------------------------------	
	
	profiler:Pause()	
	for j = 1, 500, 1 do
		Sleep(1)
	end 
	local Elapsed_2 = profiler:Elapsed()
	print("Elapsed_2 should be equal to Elapsed_1, Elapsed_2 ="..tostring(Elapsed_2))
------------------------------------------------------	
	profiler:Resume()
	
	for k = 1, 100, 1 do
		Sleep(1)
	end
	local Elapsed_3 = profiler:Elapsed()
	print("Elapsed_3 should be equal to 2 + Elapsed_1, Elapsed_3 ="..tostring(Elapsed_3))
-------------------------------------------------------

	profiler:Pause()
	profiler:Reset()
	
	for v = 1, 100, 1 do
		Sleep(1)
	end
		
	local Elapsed_4 = profiler:Elapsed()
	print("Elapsed_4 should be equal to 0 as Profiler:Reset() is after the Profiler:Pause() and there is no Profiler:Resume() before start Profiler:Elapsed(), the Elapsed_4 ="..tostring(Elapsed_4))	
		
-------------------------------------------------------

	profiler:Resume()
	
	for l = 1, 100, 1 do
		Sleep(1)
	end
	
	local Elapsed_5 = profiler:Elapsed()
	print("Elapsed_5 should be approximate to Elapsed_1, Elapsed_5 ="..tostring(Elapsed_5))
	
--------------------------------------------------------

	profiler:Pause()
	profiler:Restart()
	
	for k = 1, 100, 1 do
		Sleep(1)
	end
	
	local Elapsed_6 = profiler:Elapsed()
	print("Elapsed_6 should be approximate to Elapsed_5, as Profiler:Restart() will set the time counter to 0 then restart counting, Elapsed_6 ="..tostring(Elapsed_6))
	
----------------------------------------------------------

	profiler:Stop()
	
	for u = 1, 100, 1 do
		Sleep(1)
	end
	
	local Elapsed_7 = profiler:Elapsed()
	print("Elapsed_7 should be equal to 0 as the Profiler:Stop() will stop the profiler then reset the time counter to 0, Elapsed_7 ="..tostring(Elapsed_7))		
	
		

end

function OnStop()

end