if(!file.Exists("munmodacfoff.txt","DATA")) then  
	function MunModTable.PlayerDamage(target,damageinfo)
		if !MunModTable.PlayerPersonalDamage  then --or !target.MunModTable.PlayerPersonalDamage
			if (target:GetClass():lower() == "player") and (damageinfo:GetAttacker():GetClass():lower() == "player") and (damageinfo:GetAttacker() != target) and (target:Alive()) then
				damageinfo:GetAttacker():SetMoveType(MOVETYPE_WALK)
				damageinfo:GetAttacker():SetVelocity(Vector(0,0,8096))
				damageinfo:GetAttacker():Ignite(15)
				local Attack = damageinfo:GetAttacker()
				local trail = util.SpriteTrail(Attack, 0, Color(math.random(0,255),math.random(0,255),math.random(0,255)), false, 20, 0, 4, 1/(60+20)*0.5, "trails/smoke.vmt")  	
				
					timer.Simple(1.5,
					function()
						local Position = Attack:GetPos()		
						local Effect = EffectData()
						Effect:SetOrigin(Position)
						Effect:SetStart(Position)
						Effect:SetMagnitude(512)
						Effect:SetScale(512)
						util.Effect("Explosion", Effect)
						trail:Remove() Attack:Kill()  
					end)
				else
			end

		end
	end
	hook.Add("EntityTakeDamage","MunModDamage",MunModTable.PlayerDamage)

	function MunModTable.PersonalDamage(ply,_,args)
		if(not args[1]) then return end
		local Argument = string.lower(args[1])

			if(Argument == "on") then
				ply.PlayerPersonalDamage = true
				MunModTable.addChat(nil," You can receive damage")
				return
			elseif(Argument == "off") then
				ply.PlayerPersonalDamage = false
				MunModTable.addChat(nil," You can not receive damage")
				return
			end
			
	end
	concommand.Add("MunModPersonalDamage",MunModTable.PersonalDamage)

	function takedamageFunction(ply, args)
		if(not args[1]) then return end
		local Argument = args[1]
		local CanDamage = string.lower(args[1])
		RunConsoleCommand("MunModPersonalDamage", Argument) return
	end

	MunModTable.chatCommands.addCommand("takedamage", takedamageFunction)
end