hook.Add("CanProperty","myproperlie",function(ply,proper,ent)
	ulx.logString(ply:Nick() .. " used " .. proper .. " on " .. ent:GetModel() .. " - Owner is " .. tostring(ent:CPPIGetOwner()),true)
end)

hook.Add("PlayerSpawnVehicle","MunDidSpawnVehicle",function(ply,str,name,tab)
	--MunModTable.addChat(nil,str)
	if(str == "models/buggy.mdl" or str=="models/airboat.mdl") then
		MunModTable.addChat(ply,"That item is blacklisted, Sorry!")
		return false
	end
end)

hook.Add("CanPlayerEnterVehicle","MunModCheckVehicle",function(ply,veh)
	if(veh:CPPIGetOwner()) then
		MunModTable.addChat(veh:CPPIGetOwner(),ply:Nick() .. " just entered your vehicle!")
		ulx.logString(ply:Nick() .. " Entered " .. veh:CPPIGetOwner():Nick() .. "'s vehicle.")
	end
	return
end)

function gmsave.SaveMap(ply)
	MunModTable.addChat(nil, ply:Nick() .. " tried to save the map.")
end