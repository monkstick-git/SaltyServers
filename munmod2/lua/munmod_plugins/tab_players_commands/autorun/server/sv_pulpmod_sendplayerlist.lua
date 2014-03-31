local category = 3

util.AddNetworkString("MunMod_UpdatePlayerList")

local function getPropPlayer()

	local players = player.GetAll()
	local allProps = ents.FindByClass("prop_*")

	local playersProps = {}

	for k,v in pairs(ents.FindByClass("prop_*")) do
		
		local owner = v:CPPIGetOwner()
		if(IsValid(owner) and owner:IsPlayer()) then
				
			playersProps[owner] = (playersProps[owner] or 0) + 1

		end

	end
	return playersProps

end

local function update(ply)

	net.Start("MunMod_UpdatePlayerList")
		net.WriteTable(getPropPlayer())
	net.Send(ply)

end

hook.Add("MunMod_NewSubscription", "PlayerList", function(ply, plyCategory)

	if(plyCategory != category) then return end

	update(ply);

end)