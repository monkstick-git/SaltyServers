--[[----------------------------------------------------------------
	Send to clients who subscribed all the updates about the leaks.
]]------------------------------------------------------------------

util.AddNetworkString("MunMod_UpdateMemoryLeak")
util.AddNetworkString("MunMod_UpdateFunctionLeak")

local leakCategory = 1
local previousMemLeak = 0
local previousFuncLeak = 0

-- Send to player the updates
local function updateMemory(ply)

	net.Start("MunMod_UpdateMemoryLeak")
		net.WriteInt(previousMemLeak, 32)
	net.Send(ply)

end

local function updateFunctions(ply)

	net.Start("MunMod_UpdateFunctionLeak")
		net.WriteInt(previousFuncLeak, 16)
	net.Send(ply)

end

-- Functions to send to everyone
local function updateAllPlayersMemory()

	for k,v in pairs(MunModTable.getAllPlayersSubscribed(leakCategory)) do

		if(v and IsValid(v) and v:IsPlayer()) then
			updateMemory(v)
		end

	end

end

local function updateAllPlayersFunction()

	for k,v in pairs(MunModTable.getAllPlayersSubscribed(leakCategory)) do

		if(v and IsValid(v) and v:IsPlayer()) then
			updateFunctions(v)
		end

	end

end


-- Hook to the leaks the sending of the updates

hook.Remove("MunMod_MemoryLeak", "GUI_information")
hook.Remove("MunMod_FunctionLeak", "GUI_information")

hook.Add("MunMod_MemoryLeak", "GUI_information", function(mem)

	previousMemLeak = mem
	updateAllPlayersMemory()

end)

hook.Add("MunMod_FunctionLeak", "GUI_information", function(func)

	previousFuncLeak = func
	updateAllPlayersFunction()

end)

hook.Add("MunMod_NewSubscription", "LeakFunctions", function(ply, category)

	if(category != leakCategory) then return end

	updateFunctions(ply)
	updateMemory(ply)

end)
