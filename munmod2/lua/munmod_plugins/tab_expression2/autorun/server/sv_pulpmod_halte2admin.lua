concommand.Add("halte2admin", function(player, _, args)

	local E2 = tonumber(args[1])
	if (!E2) then return end
	E2 = Entity(E2)
	if (!E2 or !E2:IsValid() or E2:GetClass() != "gmod_wire_expression2") then return end
	--if (canhas( player )) then return end
	if (E2.error) then return end
	if (E2.player == player or (E2Lib.isFriend(E2.player,player) and E2.player:GetInfoNum("wire_expression2_friendwrite", 0) == 1) or player:IsAdmin()) then
		E2:PCallHook( "destruct" )
		E2:Error( "Execution halted (Triggered by: " .. player:Nick() .. ")", "Execution halted" )
		if (E2.player != player) then
			WireLib.AddNotify( player, "Expression halted.", NOTIFY_GENERIC, 5, math.random(1,5) )
			MunModTable.addChat(player,"Expression halted." )
		end
	else
		WireLib.ClientError( "You do not have premission to halt this E2.", player )
	end
	
end)