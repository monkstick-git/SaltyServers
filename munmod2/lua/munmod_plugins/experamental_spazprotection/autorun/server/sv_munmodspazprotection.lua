local entitytable1 = {}
local B = 0
local A = 0
local TimerTime = 5
local A1 = 0

function MunModTempFunction()
	A = 0
	A1 = 0
	entitytable1 = {}
		for k,v in pairs (ents.FindByClass("prop_physics")) do 
			A1 = A1 + 1
				if(v:CPPIGetOwner()) then
						local phys1 = v:GetPhysicsObject()
							if(phys1:IsValid()) then
								if(tostring(v:GetParent()) == "[NULL Entity]") then
									if v:GetPhysicsObject():GetEnergy() > 10 then
										table.insert(entitytable1,v)
										A=A+1
									end
								end
							end
				end
		end
	timer.Adjust("MunModGetEnts",((5) + A1/100),0,MunModTempFunction)
end

function MunModTable.Touch()
	local Nick1 = ""
	B=B+1
		if(B > A) then B = 0 end
		if(not entitytable1[B]) then B = 0 return end
		
		if(IsValid(entitytable1[B]) and entitytable1[B]:GetCollisionGroup() != 10) then 
			local Energy = math.floor((entitytable1[B]:GetPhysicsObject():GetEnergy()/entitytable1[B]:GetPhysicsObject():GetMass()) / 10000)
			if(Energy > 1000) then 
			--	entitytable1[B].SpazFlags = entitytable1[B].SpazFlags and ( entitytable1[B].SpazFlags + 1 ) or 1
				 entitytable1[B]:CPPIGetOwner().SpazFlags = entitytable1[B]:CPPIGetOwner().SpazFlags and (entitytable1[B]:CPPIGetOwner().SpazFlags + 1) or 1
				local Flags = entitytable1[B]:CPPIGetOwner().SpazFlags or 0
				local entvel = entitytable1[B]:GetPhysicsObject():GetVelocity()
				local entstress = entitytable1[B]:GetPhysicsObject():GetInertia()
					for k,v in pairs(constraint.GetAllConstrainedEntities(entitytable1[B])) do
						if(Flags >= 3) then
						v:GetPhysicsObject():EnableMotion(false)
						else
						v:GetPhysicsObject():Sleep()
						end
						--v:GetPhysicsObject():EnableMotion(false)
						--v:GetPhysicsObject():Sleep()
						Nick1 = v:CPPIGetOwner():Nick()
				end
				MunModTable.addChat(nil,"[DEBUG MODE] - Freezing "..tostring(Nick1).."'s contraption, suspected Spazzing.")
				MunModTable.addChat(nil,"[DEBUG MODE] - A: " .. tostring(Energy) .. " B: " .. entitytable1[B]:GetModel() .. " C: " .. tostring(entstress))
			end
		end

	if(B > A) then B = 0 end
end
hook.Add("Tick","MunModTouch",MunModTable.Touch)
timer.Create("MunModGetEnts",TimerTime,0,MunModTempFunction)
timer.Create("MunModSetSpazFlags",120,0,function()
	for k,v in pairs(player.GetAll()) do
		v.SpazFlags = math.Clamp(v.SpazFlags and (v.SpazFlags - 1) or 0,0,100)
		--MunModTable.addChat(nil,v:Nick() .. "'s flags are now " .. v.SpazFlags)
	end
end)