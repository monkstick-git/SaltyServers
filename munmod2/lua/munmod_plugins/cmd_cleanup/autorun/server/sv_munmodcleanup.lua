function MunModTable.RocketProps(ply,_,args)
	local entitytable1 = {}
		if(!IsValid(ply) or ply:IsAdmin() or ply:EntIndex() == tonumber(args[1])) then
			local Player = ply -- Dont mess with
			local Target = "Nobody" -- Dont mess with
			local B = 0
			local A = 0
			MsgAll(args[1])
				if(tostring(args[1])=="*") then Target = "*" else if(args[1]==nil) then Target = ply:EntIndex() else Target = args[1] end end -- Checks whether or not * is the arg	
			if(Target != "*") then -- if its not, then it must be a player
				for k,v in pairs (ents.FindByClass("*")) do
					if(v:CPPIGetOwner()) then -- if there is an fpp owner, carry on
						if (v:CPPIGetOwner():EntIndex() == tonumber(Target)) then -- If the ent index of the owner of the prop is the same as our args, carry on 
							local phys1 = v:GetPhysicsObject()
								if(phys1:IsValid()) then
									v:GetPhysicsObject():EnableMotion(false) -- Freeze the object's
									table.insert(entitytable1,v)
								else
								end
						end 
					end
				end
				MunModTable.addChat(nil," Cleaned up "..player.GetByID(Target):Nick().."'s props!") -- ******Change this for the correct script
				local Total = (100 / table.Count(entitytable1)) / 25
				timer.Create("MunModCleanupTimer",Total,table.Count(entitytable1),function()
				A=A+1
					if(IsValid(entitytable1[A])) then
						local phys = entitytable1[A]:GetPhysicsObject()
						phys:EnableGravity(false)
						phys:EnableMotion(true) 
						constraint.RemoveAll(entitytable1[A])
						phys:EnableCollisions(false)
						phys:SetMass(50000)
						phys:SetVelocity( Vector(math.random(-800,800),math.random(-800,800),math.random(1500)))
					end
					
					timer.Simple(1,function()
					B=B+1
					if(!IsValid(entitytable1[B])) then return end
					--MsgAll(tostring(entitytable1[B]))
					entitytable1[B]:SetVelocity( Vector(0,0,2000))
					local Position = entitytable1[B]:GetPos()		
					local Effect = EffectData()
					Effect:SetOrigin(Position)
					Effect:SetStart(Position)
					Effect:SetMagnitude(512)
					Effect:SetScale(512)
				--	util.Effect("AntlionGib", Effect)
				--	util.Effect("balloon_pop", Effect)
					entitytable1[B]:Remove()
					end)
								
				end)
			return
			end
		
		if(Target == "*") then -- If the arg was * (All players)
				for k,v in pairs (ents.FindByClass("*")) do
					if(v:CPPIGetOwner()) then -- if there is an fpp owner, carry on
						local phys1 = v:GetPhysicsObject()
							if(phys1:IsValid()) then
								v:GetPhysicsObject():EnableMotion(false) -- Freeze the object's
								table.insert(entitytable1,v)
							else
							end

					end
				end
			MunModTable.addChat(nil," Cleaning up everybodys props!") -- ******Change this for the correct script
			local Total = (100 / table.Count(entitytable1)) / 25
			
			timer.Create("MunModCleanupTimer",Total,table.Count(entitytable1),function()
				A=A+1
				if(IsValid(entitytable1[A])) then
					local phys = entitytable1[A]:GetPhysicsObject()
					phys:EnableGravity(false)
					phys:EnableMotion(true) 
					constraint.RemoveAll(entitytable1[A])
					phys:EnableCollisions(false)
					phys:SetMass(50000)
					phys:SetVelocity( Vector(math.random(-800,800),math.random(-800,800),math.random(1500)))
				end
				timer.Simple(1,function()
					B=B+1
					MsgAll(tostring(entitytable1[B]))
					entitytable1[B]:SetVelocity( Vector(0,0,2000))
					local Position = entitytable1[B]:GetPos()		
					local Effect = EffectData()
					Effect:SetOrigin(Position)
					Effect:SetStart(Position)
					Effect:SetMagnitude(512)
					Effect:SetScale(512)
				--	util.Effect("AntlionGib", Effect)
				--	util.Effect("balloon_pop", Effect)
					entitytable1[B]:Remove()
				end)
								
			end)
			return
		end
		end
 end	
concommand.Add("munmodcleanupprops",MunModTable.RocketProps)

function cleanuppropsFunction(ply, args)
	local PlayerNumber = 0
	local PlayerIndex = 0
	if(not args[1]) then return end
	local targetName = string.lower(args[1])
		if(args[1] != "*") then
			for k,v in pairs(player.GetAll()) do
				if(string.find(string.lower(v:Nick()),targetName)) then
					PlayerNumber = PlayerNumber + 1
					PlayerIndex = v:EntIndex()
				end		

			end
		end
		
	if(PlayerNumber == 1) then
		if(ply:IsAdmin() or ply:EntIndex() == PlayerIndex) then
			RunConsoleCommand("munmodcleanupprops", PlayerIndex) return
		else
			MunModTable.addChat(ply," You do not have permission to use this command on that player")
		end
			elseif(PlayerNumber > 1) then
				MunModTable.addChat(nil," Too many players found. Try refining the search criteria") return
					elseif(PlayerNumber == 0 and args[1] != "*") then
						MunModTable.addChat(nil," No players found!") return
							elseif(args[1] == "*") then
								if(ply:IsAdmin()) then
									RunConsoleCommand("munmodcleanupprops", "*")
								end
	end
end

MunModTable.chatCommands.addCommand("cleanupprops", cleanuppropsFunction)


