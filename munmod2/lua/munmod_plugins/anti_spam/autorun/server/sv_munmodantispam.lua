function MunModTable.AntiPropSpam( ply, model, ent )
	if(not ply.MunModPropCount1) then ply.MunModPropCount1 = 0 end
	ply.MunModPropCount1 = ply.MunModPropCount1 + 2
	local Sin = math.sin(ply.MunModPropCount1*ent:GetModelRadius()*5)*(math.abs(ent:GetModelRadius())*1)
	local Cos = math.cos(ply.MunModPropCount1*ent:GetModelRadius()*5)*(math.abs(ent:GetModelRadius())*1)
	Prop = ent:GetPhysicsObject( )
		if(Prop:IsValid() and (!ply.MunModCanSpam)) then
			Prop:EnableMotion(false)	
				if(not AdvDupe2 or AdvDupe2.JobManager.PastingHook == false) then
					ent:GetPhysicsObject():SetPos( ent:GetPos() + Vector(Sin,Cos,20))
					Prop:SetAngles(Angle(0,90,0))
				end
		end
end

hook.Add("PlayerSpawnedProp","MunModAntiSpam",MunModTable.AntiPropSpam)

function letmespamFunction(ply, args)
	local PlayerNumber = 0
	local PlayerIndex = 0
	if(not args[1]) then return end
	local targetName = string.lower(args[1])
		
	for k,v in pairs(player.GetAll()) do
			
		if(string.find(string.lower(v:Nick()),targetName)) then
			PlayerNumber = PlayerNumber + 1
			PlayerIndex = v
		end		

	end
	
	if(PlayerNumber == 1) then
		if(!IsValid(ply) or ply:IsAdmin()) then
			MunModTable.addChat(nil,Color(200,200,200), "AntiSpam has been turned ",Color(255,0,0)," OFF ",Color(200,200,200),"for: ", team.GetColor(ply:Team())," "..ply:Nick())
			PlayerIndex.MunModCanSpam = true 
		else
			MunModTable.addChat(ply," You do not have permission to use this command on that player")
		end
	elseif(PlayerNumber > 1) then
		MunModTable.addChat(nil," Too many players found. Try refining the search criteria") return
	elseif(PlayerNumber == 0) then
		MunModTable.addChat(nil," No players found!") return
	end
end

function dontletmespamFunction(ply, args)
	local PlayerNumber = 0
	local PlayerIndex = 0
	if(not args[1]) then return end
	local targetName = string.lower(args[1])
		
	for k,v in pairs(player.GetAll()) do
			
		if(string.find(string.lower(v:Nick()),targetName)) then
			PlayerNumber = PlayerNumber + 1
			PlayerIndex = v
		end		

	end
	
	if(PlayerNumber == 1) then
		if(!IsValid(ply) or ply:IsAdmin()) then
			MunModTable.addChat(nil,Color(200,200,200), "AntiSpam has been turned ",Color(0,255,0)," ON ",Color(200,200,200),"for: ", team.GetColor(ply:Team())," "..ply:Nick())
			PlayerIndex.MunModCanSpam = false 
		else
			MunModTable.addChat(nil," You do not have permission to use this command on that player")
		end
	elseif(PlayerNumber > 1) then
		MunModTable.addChat(nil," Too many players found. Try refining the search criteria") return
	elseif(PlayerNumber == 0) then
		MunModTable.addChat(nil," No players found!") return
	end
end

MunModTable.chatCommands.addCommand("allowspam", letmespamFunction)
MunModTable.chatCommands.addCommand("stopspam", dontletmespamFunction)

concommand.Add("MunModPlayerSpamOn",dontletmespamFunction)
concommand.Add("MunModPlayerSpamOff",letmespamFunction)
