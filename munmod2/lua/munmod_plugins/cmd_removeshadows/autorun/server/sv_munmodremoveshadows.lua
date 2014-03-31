function shadowFunction(ply, _)
	if(ply:IsAdmin()) then
		for k,v in pairs(ents.GetAll()) do
			v:DrawShadow(false)
		end
	MunModTable.addChat(nil,ply:Nick().." removed all shadows.")
	end
end

function shadowTimerFunction(ply, _)
	if(ply:IsAdmin()) then
		MunModTable.addChat(nil,"Shadows are now auto removed every 60 seconds!")
		timer.Create("AutoRemove",60,0,function()
			for k,v in pairs(ents.GetAll()) do
				v:DrawShadow(false)
			end
			--MunModTable.addChat(nil,"Automated script removed shadows.")
		end)	
end
end

function shadowTimerFunctionOff(ply, _)
	if(ply:IsAdmin()) then
	timer.Remove("AutoRemove")
		MunModTable.addChat(nil,"Shadows are no longer being removed,  restoring shadows...")
			for k,v in pairs(ents.GetAll()) do
				v:DrawShadow(true)
			end
	end
end



MunModTable.chatCommands.addCommand("shadows", shadowFunction)
MunModTable.chatCommands.addCommand("removeshadows", shadowTimerFunction)
MunModTable.chatCommands.addCommand("keepshadows", shadowTimerFunctionOff)
