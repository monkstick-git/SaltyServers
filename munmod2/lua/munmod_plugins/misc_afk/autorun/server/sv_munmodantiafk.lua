if(game.SinglePlayer()) then 
	print("Single player game detected, Anti AFK disabled.")
	return 
end

function MunModTable.AntiAfk(ply)
	ply.MunModAfkFlags = 0 
	if(ply.IsAfk == true) then MunModTable.addChat(nil,team.GetColor(ply:Team()),ply:Nick(),Color(200,200,200)," is now ",Color(0,255,0),"back ",Color(200,200,200),"at their keyboard!") ply.IsAfk = false end  
end

function MunModTable.SetAfkTime(ply,seconds)
	sql.Query("UPDATE munmod_afk_info SET player_limit = "..tostring(seconds).." WHERE player_id = '"..ply:SteamID().."'")
	MunModTable.addChat(nil,"Adjusted "..ply:Nick().."'s Afk timer to "..seconds.." seconds!")
	ply.AfkLimit = tonumber(seconds)
end



timer.Create("MunModAntiAfkTimer",10,0,function()
	for k,v in pairs(player.GetAll()) do
		--local TempTime = math.Clamp( math.Round( (v.AfkLimit - 120) + (v:GetUTime() / 60 / 60 / 20)),0,10)
		v.MunModAfkFlags = v.MunModAfkFlags + 10
		if(v.MunModAfkFlags > 120 and v.IsAfk == false) then
			MunModTable.addChat(nil,team.GetColor(v:Team()),v:Nick(),Color(200,200,200)," is now ",Color(255,0,0),"Away ",Color(200,200,200),"from keyboard!")
			v.IsAfk = true
		end
		if(v.MunModAfkFlags > v.AfkLimit) then
			MunModTable.addChat(nil,team.GetColor(v:Team()),v:Nick(),Color(200,200,200)," has been kicked for idling.") v:Kick("[MunMod] - You have automatically been kicked from the server for idling") 
		end
	end
end)

function MunModTable.CreateAfkTable()
	if(!sql.TableExists("munmod_afk_info")) then
		MsgAll("Creating the afk info table...")
		sql.Query("CREATE TABLE munmod_afk_info (player_id varchar(255),player_limit int)")
	if(sql.TableExists("munmod_afk_info")) then
		MsgAll("Successfully made the player info table")
	else
		MsgAll("Something went horribly, horribly wrong!")
	end
	
	else
		MsgAll("The player info table already exists!")
	end
end

hook.Add("PlayerButtonDown","MunModButtonUp",MunModTable.AntiAfk)
hook.Add( "Initialize", "MunModAfkTimers", MunModTable.CreateAfkTable )

hook.Add( "PlayerInitialSpawn", "MunModAfkSpawn", function(ply)
	ply.IsAfk = false
	ply.MunModAfkFlags = 0 
	
	if(!sql.QueryValue("SELECT player_limit FROM munmod_afk_info WHERE player_id = '"..ply:SteamID().."'")) then
		ply.AfkLimit = 420
		sql.Query("INSERT INTO munmod_afk_info (`player_id`, `player_limit`)VALUES ('"..ply:SteamID().."', '"..tostring(ply.AfkLimit).."')")
	else
		ply.AfkLimit = tonumber(sql.QueryValue("SELECT player_limit FROM munmod_afk_info WHERE player_id = '"..ply:SteamID().."'"))
	end 
	MunModTable.AntiAfk(ply)
	
end)

function AfkTimerFunction(ply, args)
	local PlayerNumber = 0
	local PlayerIndex = "nil"
	if(not args[1]) then return end
	if(not args[2]) then return end
	local targetName = string.lower(args[1])
		
	for k,v in pairs(player.GetAll()) do
			
		if(string.find(string.lower(v:Nick()),targetName)) then
			PlayerNumber = PlayerNumber + 1
			PlayerIndex = v
		end		

	end
	
	if(PlayerNumber == 1) then
		if(ply:IsAdmin()) then
			MunModTable.SetAfkTime(PlayerIndex,args[2]) return
		else
			MunModTable.addChat(ply,"You do not have permission to use this command on that player")
		end
	elseif(PlayerNumber > 1) then
		MunModTable.addChat(ply," Too many players found. Try refining the search criteria") return
	elseif(PlayerNumber == 0) then
		MunModTable.addChat(ply," No players found!") return
	end
	
end

MunModTable.chatCommands.addCommand("afktime", AfkTimerFunction)