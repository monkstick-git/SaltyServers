function MunModTable.ChangeMap(ply,_,args)
if(!IsValid(ply)) then MsgAll("ITS NOT VALID") end
	local PlayerName = "" 
	if(!IsValid(ply)) then
		 PlayerName = "Console" 
	else PlayerName = ply:Nick()
	end
	
	if(!IsValid(ply) or ply:IsAdmin()) then
		if(args[1]) then
			ServerLog(PlayerName.."Changed Level to "..args[1])
			RunConsoleCommand("changelevel",args[1])
		end
	end
end
concommand.Add("MunModChangeLevel",MunModTable.ChangeMap)