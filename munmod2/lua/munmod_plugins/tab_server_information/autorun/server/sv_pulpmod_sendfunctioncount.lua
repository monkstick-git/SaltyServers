local functionCount = 0
local category = 1

util.AddNetworkString("MunMod_UpdateFunctionCount")

local function update(ply)

	net.Start("MunMod_UpdateFunctionCount")
		net.WriteInt(functionCount, 16)
	net.Send(ply)

end

local function updateAllPlayers()

	for k,v in pairs(MunModTable.getAllPlayersSubscribed(category)) do

		if(v and IsValid(v) and v:IsPlayer()) then
			update(v)
		end

	end

end

hook.Add("MunMod_ChangedFunctionCount", "GUI_Information", function(func)

	functionCount = func
	updateAllPlayers()

end)

hook.Add("MunMod_NewSubscription", "FunctionCount", function(ply, plyCategory)

	if(plyCategory != category) then return end

	update(ply);

end)