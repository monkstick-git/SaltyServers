function MunModTable.ServerDamage(ply,_,args)
	MsgAll("Command recieved")
	if(not args[1] or type(args[1]) != "string" or !ply:IsAdmin()) then return end
	
	local Argument = string.lower(args[1])
	
	if Argument == "on" then
		MunModTable.PlayerPersonalDamage = true
		SetGlobalBool("PlayerDamage", true)
		MunModTable.addChat(nil," Enabled Player Damage")
	elseif Argument == "off" then
		MunModTable.PlayerPersonalDamage = false
		SetGlobalBool("PlayerDamage", false)
		MunModTable.addChat(nil," Disabled Player Damage")
	end
end

concommand.Add("MunModServerDamage",MunModTable.ServerDamage)

function serverDamageFunction(_, args)
	RunConsoleCommand("MunModServerDamage", args[1])
end

MunModTable.chatCommands.addCommand("serverdamage", serverDamageFunction)
