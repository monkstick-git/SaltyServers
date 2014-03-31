function BlockWorldRopes(ply, tr, mode)
	
	 if (mode == "precision_align"
	 or mode == "advdupe2"
	 or mode == "precision"
	 or mode == "ballsocket"
	 or mode == "ballsocket_adv"
	 or mode == "ballsocketcentre"
	 or mode == "xcfmenu"
	 or mode == "acfmenu"
	 or mode == "measuringstick"
	 or mode == "total_mass"
	 or mode == "camera"
	 or mode == "textscreen"
	 or mode == "lemongate"
	 or mode == "wire_expression2"
	 or mode == "nocollide_world") and (!ply.MunModWorld) then
	--	MsgAll("[MunMod] - "..ply:Nick().." Used tool: "..mode.." on object: "..tr.Entity:GetModel().." and class is: "..tr.Entity:GetClass( ))
		ServerLog("[MunMod] - "..ply:Nick().." Used tool: "..mode.." on object: "..tr.Entity:GetModel().." and class is: "..tr.Entity:GetClass( ) .. "\n")
	return
	end	 
	
	if(mode == "paint") then
		return false
	end
	
		if (tr.HitWorld) then -- if The players Trace hit the world
			MunModTable.addChat(ply," You cannot use "..mode.." with the world.")
			--MsgAll("[MunMod] - "..ply:Nick().." BLOCKED tool: "..mode.." on object: "..tr.Entity:GetModel().." and class is: "..tr.Entity:GetClass( ))
			ServerLog("[MunMod] - "..ply:Nick().." BLOCKED tool: "..mode.." on object: "..tr.Entity:GetModel().." and class is: "..tr.Entity:GetClass( ) .. "\n")
			return false
		end

end
hook.Add("CanTool", "BlockWorldRopes", BlockWorldRopes)


--Finding the toolgun mode in singleplayer:      lua_run print(player.GetAll()[1]:GetTool().Mode)
