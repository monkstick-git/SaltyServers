function MunModTable.RemoveDrag(ply) 
	for k,v in pairs (ents.FindByClass("prop_physics"))
		do
			if(v:CPPIGetOwner()) then if (v:CPPIGetOwner() == (ply)) then
				v:GetPhysicsObject():EnableDrag(false) 
				v:GetPhysicsObject():SetDamping(0,0)
				--MsgAll(tostring(v))
			end 
		end
	end
MunModTable.addChat(nil,"Removed drag on "..ply:Nick().."'s props")
end

concommand.Add("munmodremovedrag",MunModTable.RemoveDrag)
MunModTable.chatCommands.addCommand("drag", MunModTable.RemoveDrag)