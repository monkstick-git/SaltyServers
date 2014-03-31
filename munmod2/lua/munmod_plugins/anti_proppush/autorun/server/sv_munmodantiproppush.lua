function MunModTable.PropPush(ply, ent)
	if not (ent:GetClass():lower() == "player") then
	ent.IsBeingHeld = ent.IsBeingHeld or false
			if(ent.IsBeingHeld == false and ent:CPPICanPhysgun(ply)) then
				ent.CollisionToggle = ent:GetCollisionGroup()
				ent:SetCollisionGroup(20)
				ent.IsBeingHeld = true
				ent.HeldBy = ply
			else
				return false
			end
		end
end

function MunModTable.PropPushDrop(ply, ent)
	if(ent.HeldBy == ply) then
		ent:SetCollisionGroup(ent.CollisionToggle)
		ent.IsBeingHeld = false
		ent.HeldBy = "Nobody"
	
		ent:GetPhysicsObject():SetPos( ent:GetPos() )
		ent:GetPhysicsObject():Sleep()
		ent:GetPhysicsObject():Wake()			
		for k,v in pairs( constraint.GetAllConstrainedEntities(ent) ) do
			v:GetPhysicsObject():SetPos( v:GetPos() )
			v:GetPhysicsObject():Sleep()
			v:GetPhysicsObject():Wake()
		end
		
	end
end

 hook.Add("PhysgunPickup","MunPhysgunPickup",MunModTable.PropPush)
 hook.Add("PhysgunDrop","MunPhysgunDrop",MunModTable.PropPushDrop)

-- MunModTable.CanThrow = false

-- function MunModTable.PropPush(ply, ent)
	-- ply.MunModNoCollided = false
	-- if not (ent:GetClass():lower() == "player") then
		-- if(ent:CPPIGetOwner():EntIndex() == tonumber(ply:EntIndex())) then
		-- if(!ply.MunModCanCollide) then
			-- if (ent:GetCollisionGroup()==20) then
				-- ply.MunModNoCollided=true
			-- end
			-- ent:SetCollisionGroup(COLLISION_GROUP_WORLD)
		
		-- end
		-- end
		-- if (ent:GetClass():lower() == "player") then

			-- return false
		-- end

	-- end
-- end

-- function MunModTable.PropPushDrop(ply, ent)
	-- if not (ent:GetClass():lower() == "player") then
		-- if(ply.MunModNoCollided == false) then
			-- if(MunModTable.CanThrow == false) then
					-- ent:GetPhysicsObject():SetPos( ent:GetPos() )
					-- ent:GetPhysicsObject():Sleep()
					-- ent:GetPhysicsObject():Wake()			
					-- for k,v in pairs( constraint.GetAllConstrainedEntities(ent) ) do
							-- v:GetPhysicsObject():SetPos( v:GetPos() )
							-- v:GetPhysicsObject():Sleep()
							-- v:GetPhysicsObject():Wake()
					-- end
			-- end
				-- ent:SetCollisionGroup(0)
		-- end
		-- if(ply.MunModNoCollided == true ) then
			-- ent:SetCollisionGroup(20)
		-- end
		-- if (ent:GetClass():lower() == "player") then
			-- return true
		-- end

	-- end

-- end

-- function ThrowFunction(ply)
	-- if(ply:IsAdmin()) then
		-- MunModTable.CanThrow = !MunModTable.CanThrow
		-- MunModTable.addChat(nil,"Throwing props is now: " .. tostring(MunModTable.CanThrow))
	-- end
-- end



-- hook.Add("CanPlayerUnfreeze","MunModOnUnfreeze",function(ply,ent,phys)
	-- if(ent:CPPIGetOwner() == ply) then
		-- MunModTable.addChat(nil,ply:Nick() .. "    |    " .. ent:GetModel())
		-- ent:SetCollisionGroup(20)
		-- timer.Create("MunModTimer" .. tostring(RealTime()),5,1,function()
			-- MunModTable.PropPushDrop(ply, ent)
		-- end)
	-- end
-- end)

-- MunModTable.chatCommands.addCommand("allowthrow", ThrowFunction)