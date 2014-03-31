--[[
Prop/Entity count changed:
	Trigger a hook every time the prop count changed.

		Use hook.Add("MunMod_PropCountChanged","yourHookName", yourFunction)
		or  hook.Add("MunMod_EntCountChanged", "yourHookName", yourFunction)
		to get the prop/entity count (gave in first argument to yourFunction).

]]--
local lastPropCount = MunModTable.getPropCount()

local function triggerPropDetection()

	local props = MunModTable.getPropCount()

	if(props != lastPropCount) then
		hook.Call("MunMod_PropCountChanged", {}, props)
	end

	lastPropCount = props

end
timer.Create("MunMod_CheckPropCount", 60, 0, triggerPropDetection)

local lastEntCount = MunModTable.getEntCount()

local function triggerEntDetection()

	local ent = MunModTable.getEntCount()

	if(ent != lastEntCount) then
		hook.Call("MunMod_EntCountChanged", {}, ent)
	end

	lastEntCount = ent

end
timer.Create("MunMod_CheckEntCount", 60, 0, triggerEntDetection)

hook.Add("PlayerSpawnedProp", "MunMod_Prop/Ent Hook", function()

	triggerEntDetection()
	triggerPropDetection()

end)

hook.Add("PlayerSpawnedNPC", "MunMod_Prop/Ent Hook", triggerEntDetection)
hook.Add("PlayerSpawnedEffect", "MunMod_Prop/Ent Hook", triggerEntDetection)
hook.Add("PlayerSpawnedRagdoll", "MunMod_Prop/Ent Hook", triggerEntDetection)
hook.Add("PlayerSpawnedSENT", "MunMod_Prop/Ent Hook", triggerEntDetection)
hook.Add("PlayerSpawnedVehicle", "MunMod_Prop/Ent Hook", triggerEntDetection)
