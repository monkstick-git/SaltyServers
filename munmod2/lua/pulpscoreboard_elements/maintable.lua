include("pulpscoreboard_elements/maintable_elements/playerlist.lua")


local MainTable = {}
local margin = 30
function MainTable:Init()
	self.playerList = vgui.Create("PulpScoreboard_PlayerList", self)
	self.playerList:SetPos(0, margin+2)
	
	-- We add all the players in the scoreboard

	local tablePlayers = {}
	for k,v in pairs(player.GetAll()) do
		if(tablePlayers[v:Team()]) then
			table.insert(tablePlayers[v:Team()], v)
		else
			tablePlayers[v:Team()] = {v}
		end
	end
	
	for k,v in SortedPairs(tablePlayers) do
		for _,v2 in pairs(v) do
			self.playerList:AddRow(v2)
		end	
	end
	
	-- We override setSize so the other elements will be too
	local tempSetSize = self.SetSize
	self.SetSize = function(...)
		local result = tempSetSize(...) 
		self.playerList:SetSize(self:GetWide(), self:GetTall()-margin-2)
		return result
	end 
end


function MainTable:Paint()

	surface.SetDrawColor(Color(0, 0, 0, 150))
	surface.DrawRect(0, 0, self:GetWide(), margin)
	
	local tall = margin
	local wide = self:GetWide()
	
	local lastY = wide-tall
	draw.DrawText("O", "PulpScoreboard_couture", lastY+tall*0.25, 7.5, Color(255,255,255,255), 5)
	
	lastY = lastY-2-tall*2
	draw.DrawText("PING", "PulpScoreboard_couture", lastY+tall*0.5, 7.5, Color(255,255,255,255), 5)
	
	lastY = lastY-2-tall*2
	draw.DrawText("TIME", "PulpScoreboard_couture", lastY+tall*0.5, 7.5, Color(255,255,255,255), 5)
	
	lastY = lastY-2-tall*4
	draw.DrawText("RANK", "PulpScoreboard_couture", lastY+tall*1.4, 7.5, Color(255,255,255,255), 5)
	
	local saveLastY = lastY 
	lastY = tall+2
	draw.DrawText("      NAME", "PulpScoreboard_couture", lastY, 7.5, Color(255,255,255,255), 5)
	
	lastY = 0
	draw.DrawText("X", "PulpScoreboard_couture", lastY+tall*0.25, 7.5, Color(255,255,255,255), 5)
	
end

vgui.Register("PulpScoreboard_MainTable", MainTable, "DPanel")