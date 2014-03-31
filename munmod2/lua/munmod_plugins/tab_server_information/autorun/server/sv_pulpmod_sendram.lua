local memory = 0
local category = 1

util.AddNetworkString("MunMod_UpdateRAM")

local function update(ply)


	net.Start("MunMod_UpdateRAM")
		net.WriteInt(memory, 32)
	net.Send(ply)

end

local function updateAllPlayers()

	for k,v in pairs(MunModTable.getAllPlayersSubscribed(category)) do

		if(v and IsValid(v) and v:IsPlayer()) then
			update(v)
		end

	end

end

hook.Add("MunMod_ChangedMemory", "GUI_Information", function(mem)

	memory = mem
	updateAllPlayers()

end)

hook.Add("MunMod_NewSubscription", "RAM", function(ply, plyCategory)

	if(plyCategory != category) then return end

	update(ply);

end)