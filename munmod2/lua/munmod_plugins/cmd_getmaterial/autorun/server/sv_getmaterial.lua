MunModTable.chatCommands.addCommand("getmaterial",function(ply)
		MunModTable.addChat(ply,"Added material to your clipboard (Ctrl + v)")
		ply:SendLua("SetClipboardText(LocalPlayer():GetEyeTrace().Entity:GetMaterial())")
end)