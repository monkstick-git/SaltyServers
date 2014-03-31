util.AddNetworkString("MunMod_GUI_Subscribe")
util.AddNetworkString("MunMod_GUI_UnSubscribe")
util.AddNetworkString("MunMod_NewUnSubscription")
util.AddNetworkString("MunMod_NewSubscription")

local subscriptions = {}

function MunModTable.getAllPlayersSubscribed(category)
	category = category or 1
	return subscriptions[category] or {}
end

net.Receive("MunMod_GUI_Subscribe", function(_, ply)

	local category = net.ReadInt(8) or 1
	if(!ply or !IsValid(ply) or category < 1) then return end


	if(!subscriptions[category]) then

		subscriptions[category] = {ply}

	elseif(!table.HasValue(subscriptions[category], ply)) then

		table.insert(subscriptions[category], ply)
		hook.Call("MunMod_NewSubscription", {}, ply, category)

	end

end)

net.Receive("MunMod_GUI_UnSubscribe", function(_, ply)

	local category = net.ReadInt(8) or 1
	if(!ply or !IsValid(ply) or category < 1) then return end

	if(subscriptions[category]) then
		
		for k,v in pairs(subscriptions[category]) do
			if(v == ply) then
				
				table.remove(subscriptions[category], k)
				hook.Call("MunMod_NewUnSubscription", {}, ply, category)
				break;

			end
		end

	end
end)
