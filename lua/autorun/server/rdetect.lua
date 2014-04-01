function LogR(wep,ply,trace)
	local ent = ply:GetEyeTrace().Entity
	local ConstrainedEntities = constraint.GetAllConstrainedEntities( ent )
	
	for k,v in pairs(ConstrainedEntities) do
		MsgAll(ply:Nick().." is unfreezing "..tostring(v:GetModel()).."\n")
		ServerLog(ply:Nick().." is unfreezing "..tostring(v:GetModel()).."\n")
	end
end

hook.Add("OnPhysgunReload","LogR",LogR)