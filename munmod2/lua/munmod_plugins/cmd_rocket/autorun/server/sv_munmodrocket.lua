function MunModTable.Rocket(ply,_,args)
	if(ply:IsAdmin() or ply:EntIndex() == tonumber(args[1])) then
			Target = player.GetByID(args[1])
			Target:SetMoveType(MOVETYPE_WALK)
			Target:SetVelocity(Vector(0,0,10096))
			Target:Ignite(15)
			local trail = util.SpriteTrail(Target, 0, Color(math.random(0,10),math.random(0,10),math.random(0,10)), false, 200, 0, 4, 1/(60+20)*0.5, "trails/smoke.vmt")  	
			MunModTable.addChat(nil,Target:Nick() .. " took a one way trip to the moon.")
				timer.Simple(1.5,
				function()
					MunModTable.addChat(Target,"Boom!")
					local Position = Target:GetPos()		
					local Effect = EffectData()
					Effect:SetOrigin(Position)
					Effect:SetStart(Position)
					Effect:SetMagnitude(512)
					Effect:SetScale(512)
					util.Effect("Explosion", Effect)
					trail:Remove() Target:Kill()  
				end)
			else
	end
end
concommand.Add("MunModRocket",MunModTable.Rocket)

function rocketFunction(ply, args)
	local PlayerNumber = 0
	local PlayerIndex = 0
	if(not args[1]) then return end
	local targetName = string.lower(args[1])
		
	for k,v in pairs(player.GetAll()) do
			
		if(string.find(string.lower(v:Nick()),targetName)) then
			PlayerNumber = PlayerNumber + 1
			PlayerIndex = v:EntIndex()
		end		

	end
	
	if(PlayerNumber == 1) then
		if(ply:IsAdmin() or ply:EntIndex() == PlayerIndex) then
			RunConsoleCommand("MunModRocket", PlayerIndex) return
		else
			MunModTable.addChat(ply,"You do not have permission to use this command on that player")
		end
	elseif(PlayerNumber > 1) then
		MunModTable.addChat(ply," Too many players found. Try refining the search criteria") return
	elseif(PlayerNumber == 0) then
		MunModTable.addChat(ply," No players found!") return
	end
	
end

MunModTable.chatCommands.addCommand("rocket", rocketFunction)