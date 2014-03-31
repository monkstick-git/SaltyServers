--[[-------------------------------------------
	Hooks the message functions to the hooks.
]]---------------------------------------------

local memory = 0
local functions = 0

hook.Add("MunMod_MemoryLeak", "MunMod_DisplayMessage", function(leak)

	if(leak-100 > 0) then

		MunModTable.addChat(nil, "Memory Leak Detected! Difference Amount = ", Color(255,255,255), leak)

	end

end)

hook.Add("MunMod_FunctionLeak", "MunMod_DisplayMessage", function(leak)

	if(leak-60 > 0) then

		MunModTable.addChat(nil, "Function Leak Detected! Difference Amount = ", Color(255,255,255), leak)

	end

end)

hook.Add("MunMod_ChangedMemory", "MunMod_DisplayMessage", function(mem)

	memory = mem

	if(mem > 1000) then

		MunModTable.addChat(nil, "Server memory have exceeded 1GB. Current count : ", Color(255,255,255), math.Round(mem), Color(200,200,200),"MB.")
		MunModTable.addChat(nil, "SAVE YOUR THINGS, A SERVER CRASH IS HIGHLY LIKELY !")
		MunModTable.addChat(nil, "A map reload/change is highly recommended to avoid the server crash.")

	end

end)

hook.Add("MunMod_ChangedFunctionCount", "MunMod_DisplayMessage", function(func)

	functions = func

	if(func > 50000) then
		
		MunModTable.addChat(nil, "Functions have exceeded 50k, There is probably a leak in an addon. Current count:  ", Color(255,255,255), func)
		MunModTable.addChat(nil, "A map reload/change is highly recommended to avoid server lockups.")

	end

end)

timer.Create("MunMod_DisplayInformation", 1200, 0, function()

	MunModTable.addChat(nil, "Current Server LUA Memory usage: ", Color(255,255,255), math.Round(memory), Color(200,200,200), "MB")
	MunModTable.addChat(nil, "Current Server Functions: ", Color(255,255,255), functions)

	local props = MunModTable.getPropCount()
	MunModTable.addChat(nil, "Current Prop Count: ", Color(255,255,255), props, Color(200,200,200), " prop".. (props > 1 and "s" or ""))
	
	local entsC = MunModTable.getEntCount()
	MunModTable.addChat(nil, "Current Entity Count: ", Color(255,255,255), entsC, Color(200,200,200), " entit" .. (entsC > 1 and "ies" or "y"))

end)

