function MunerisRemoveDeadE2()
for k,v in pairs(ents.FindByClass("gmod_wire_expression2")) do
	if(v:CPPIGetOwner()) then
		if(not v:CPPIGetOwner():IsValid() ) then
		PrintMessage(HUD_PRINTTALK,"Found e2 with no owner")
		v:Remove()
		end
		--PrintMessage(HUD_PRINTTALK,"E2 with an owner "..tostring(v:CPPIGetOwner()))
	else
		
	end
end
end

timer.Create("RemoveDeadE2",180,0,function() MunerisRemoveDeadE2() end)
