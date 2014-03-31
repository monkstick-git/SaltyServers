util.AddNetworkString("MunMod_AddChatText")

function MunModTable.addChat(ply, ...)

	local args = {...}

	if(!args or #args<1) then return end
	
	local log = ""
	for k,v in pairs(args) do
		if(type(v) != "table") then
			log = log .. tostring(v)
		end
	end
	ServerLog(log.."\n")

	net.Start("MunMod_AddChatText")
		net.WriteTable(args)

	if(ply and IsValid(ply) and ply:IsPlayer()) then
		net.Send(ply)
	else
		net.Broadcast()
	end

end