include("pulpscoreboard_elements/maintable.lua")
include("pulpscoreboard_elements/titletable.lua")


hook.Add("Initialize", "PulpScoreboard", function()

	-- If the server is local there's a delay so it can receive the netmessage
	if(game.IsDedicated()) then
		net.Start("sendCountry")
			net.WriteString(system.GetCountry())
		net.SendToServer() 
	else
		timer.Simple(1, function() -- Wait 1 sec 
			net.Start("sendCountry")
				net.WriteString(system.GetCountry())
			net.SendToServer() 
		end)
	end
	

	surface.CreateFont("PulpScoreboard_couture", {
		font="Arial"
	})
	surface.CreateFont("PulpScoreboard_couture2", {
		font="Arial",
		size = 30
	})

end)

hook.Add("ScoreboardShow", "PulpScoreboard", function()

	-- Remove the previous scoreboard & menu
	if(scoreboard and IsValid(scoreboard.mainFrame)) then
		scoreboard.mainFrame:Remove()
	end
	if(IsValid(menuPulpScoreboard)) then
		menuPulpScoreboard:Remove()
	end
	  
	scoreboard = {}
	scoreboard.size = {x = ScrW()*0.5, y = ScrH()}
	scoreboard.pos = {x = ScrW()*0.5-scoreboard.size.x*0.5, y = ScrH()*0.05}

	-- Create the main panel where all the others panels are parented
	scoreboard.mainFrame = vgui.Create("DPanel")

	local mf = scoreboard.mainFrame
	local pos = scoreboard.pos 
	local size = scoreboard.size

	mf:SetPos(pos.x, pos.y)
	mf:SetSize(size.x, size.y)
	mf.Paint = function(self)
		return true
	end
	gui.EnableScreenClicker(true)
	
	-- Create the title block
	mf.titleTable = vgui.Create("PulpScoreboard_TitleTable", mf)
	mf.titleTable:SetSize(size.x, size.y*0.25-40)
	mf.titleTable:SetPos(0,20)
	
	-- Create the player list
	mf.mainTable = vgui.Create("PulpScoreboard_MainTable", mf)
	mf.mainTable:SetSize(size.x, size.y*0.75)
	mf.mainTable:SetPos(0, size.y*0.25)


	return true
end)

hook.Add("ScoreboardHide", "PulpScoreboard", function()

	gui.EnableScreenClicker(false)

	-- We remove the scoreboard & the menu
	if(scoreboard and IsValid(scoreboard.mainFrame)) then
		scoreboard.mainFrame:Remove()
	end
	if(IsValid(menuPulpScoreboard)) then
		menuPulpScoreboard:Remove()
	end
	
end)
