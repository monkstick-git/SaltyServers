--[[----------------------------------------------------------------------
Leak detection:
	Trigger a hook every time a new leak is detected.
		
		Use hook.Add("MunMod_MemoryLeak",   "yourHookName", yourFunction)
		or  hook.Add("MunMod_FunctionLeak", "yourHookName", yourFunction)
		to get the leak (gave in first argument to yourFunction).

]]------------------------------------------------------------------------

local previousFuncCount = MunModTable.getFunctionCount()
local previousMem = MunModTable.getMemoryUsage()
local lastFuncLeak = 0
local lastMemLeak = 0

function MunModTable.triggerLeakDetection()

	-- Get the memory used by LUA in MB
	local mem = MunModTable.getMemoryUsage()

	-- Get the count of functions 
	local funcCount = MunModTable.getFunctionCount()
	
	local memLeak = mem - previousMem
	if(memLeak != lastMemLeak) then

		hook.Call("MunMod_MemoryLeak", {}, memLeak)
		hook.Call("MunMod_ChangedMemory", {}, mem)
		lastMemLeak = memLeak

	end

	local funcLeak = funcCount - previousFuncCount
	if(funcLeak != lastFuncLeak) then

		hook.Call("MunMod_FunctionLeak", {}, funcLeak)
		hook.Call("MunMod_ChangedFunctionCount", {}, funcCount)
		lastFuncLeak = funcLeak

	end

	previousFuncCount = funcCount
	previousMem = mem

end

MunModTable.triggerLeakDetection()
timer.Create("MunMod_LeakDetection", 60, 0, MunModTable.triggerLeakDetection)