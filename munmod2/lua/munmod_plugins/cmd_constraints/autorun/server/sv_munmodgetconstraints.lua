function MunModTable.getPropPlayer(ply)
	if(ply:IsAdmin()) then
        local players = player.GetAll()
        local allProps = ents.FindByClass("prop_*")
		local PlayerCons = {}
        local playersProps = {}
        for k,v in pairs(ents.FindByClass("prop_*")) do
                
                local owner = v:CPPIGetOwner()
				local owner2 = v:CPPIGetOwner()
                if(IsValid(owner) and owner:IsPlayer()) then
                                
                        playersProps[owner] = (playersProps[owner] or 0) + (table.Count(constraint.GetTable(v)))
						PlayerCons[owner] = (PlayerCons[owner] or 0) + (1)
                end

        end
		MunModTable.addChat(nil,"--Constraint list--")
		for k,v in pairs(playersProps) do
			MunModTable.addChat(nil,k:Nick()..":  "..v.." | ("..math.Round(PlayerCons[k] / v,2 )..":1)")
		end
	else
	end
end


MunModTable.chatCommands.addCommand("getconstraints",MunModTable.getPropPlayer)