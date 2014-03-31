function MunModTable.OnDeath(ply)
	if(!IsValid(ply.MunModEnt) and ply:IsInWorld()) then 
		ply:GetPos()
		ply.MunModEnt = ents.Create( "prop_physics" )
		ply.MunModEnt:SetModel( "models/props_c17/gravestone002a.mdl" )
		ply.MunModEnt:SetPos( ply:GetPos() + Vector(0,0,10) )
		ply.MunModEnt:Spawn()
		constraint.Keepupright( ply.MunModEnt, ply.MunModEnt:GetAngles(), 0, 999999 )
		ply.MunModEnt:DropToFloor()
		ply.MunModEnt:SetCollisionGroup(COLLISION_GROUP_WORLD)
		ply.MunModEnt:CPPISetOwner(ply)
		timer.Simple(10,function() ply.MunModEnt:Remove() end)
	end
end

hook.Add("PlayerDeath","MunModOnDeath",MunModTable.OnDeath) 