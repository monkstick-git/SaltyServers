util.AddNetworkString("MunMod_UpdatePropCount")
util.AddNetworkString("MunMod_UpdateEntCount")

local category = 1
local previousPropCount = 0
local previousEntCount = 0

-- Send to player the updates
local function updatePropCount(ply)

	net.Start("MunMod_UpdatePropCount")
		net.WriteInt(previousPropCount, 32)
	net.Send(ply)

end

local function updateEntCount(ply)

	net.Start("MunMod_UpdateEntCount")
		net.WriteInt(previousEntCount, 32)
	net.Send(ply)

end

-- Functions to send to everyone
local function updateAllPlayersPropCount()

	for k,v in pairs(MunModTable.getAllPlayersSubscribed(category)) do

		if(v and IsValid(v) and v:IsPlayer()) then
			updatePropCount(v)
		end

	end

end

local function updateAllPlayersEntCount()

	for k,v in pairs(MunModTable.getAllPlayersSubscribed(category)) do

		if(v and IsValid(v) and v:IsPlayer()) then
			updateEntCount(v)
		end

	end

end


-- Hook to the leaks the sending of the updates

hook.Add("MunMod_PropCountChanged", "GUI_information", function(props)


	previousPropCount = props
	updateAllPlayersPropCount()

end)

hook.Add("MunMod_EntCountChanged", "GUI_information", function(ent)


	previousEntCount = ent
	updateAllPlayersEntCount()

end)

hook.Add("MunMod_NewSubscription", "Ent/Prop Functions", function(ply, plyCategory)

	if(plyCategory != category) then return end

	updatePropCount(ply)
	updateEntCount(ply)

end)