AddCSLuaFile("munmod_plugins/antispam/autorun/client/cl_init.lua")
resource.AddFile("materials/munmod/antispam/redcross.png")

util.AddNetworkString("munmod_spamtimer")

function MunModTable.QMenu(ply,ent)
	if(not ply.MunModPropSpam) then ply.MunModPropSpam = 0 end
	if(not ply.MunModLastEnt) then ply.MunModLastEnt = " " end
	if(not ply.MunModHasTriggeredSpam) then ply.MunModHasTriggeredSpam = false end
	ply.MunModCurrentSpawnTime = os.time()
	local Weap = "weld"
	if (ply:GetTool() and ply:GetTool().Mode) then Weap = ply:GetTool().Mode end
					if (ply.MunModCurrentSpawnTime == ply.MunModLastPropSpawnTime) and (not AdvDupe2 or AdvDupe2.JobManager.PastingHook == false) then
						ply.MunModPropSpam = ply.MunModPropSpam + 3
					else
						if(ply.MunModCurrentSpawnTime > 1 and ply.MunModPropSpam > 1 and ply.MunModHasTriggeredSpam == false) then
							ply.MunModPropSpam = ply.MunModPropSpam - 1
						end
					end

	ply.MunModLastPropSpawnTime = os.time()
	ply.MunModLastEnt = ent
		if(ply.MunModPropSpam > 10 and Weap != "precision_align") then
			ply.MunModHasTriggeredSpam = true
					ply:SendLua("surface.PlaySound( \"buttons/button11.wav\" )")
					MunModTable.addChat(ply,"Please wait another ",Color(255,0,0),tostring((ply.MunModPropSpam) - 10).." seconds ",Color(200,200,200),"before trying to spawn another prop")
					net.Start("munmod_spamtimer")
					net.WriteInt(tonumber((ply.MunModPropSpam) - 10),16)
					net.Send(ply)
		return false
		else
			ply.MunModHasTriggeredSpam = false
		end

end

function MunModTable.Test()
MunModTable.addChat(nil,"SPAWN MENU IS OPEN")
return false
end

timer.Create("MunModAntiSpam",1,0,function() for k,v in pairs(player.GetAll()) do if(v.MunModPropSpam) then if(v.MunModPropSpam > 0) then v.MunModPropSpam = v.MunModPropSpam - 1 end end end end)  
hook.Add("PlayerSpawnProp","MunModQMenu",MunModTable.QMenu)
