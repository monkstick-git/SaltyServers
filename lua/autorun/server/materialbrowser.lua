PrintMessage(HUD_PRINTTALK,"Running...")

hook.Add("PlayerSay","MaterialChat",function(ply,txt)
	if txt == "!getmaterial" then
		--PrintMessage(HUD_PRINTTALK,ply:GetEyeTrace().Entity:GetMaterial())
		ply:SendLua("SetClipboardText(LocalPlayer():GetEyeTrace().Entity:GetMaterial())")
	end
end)