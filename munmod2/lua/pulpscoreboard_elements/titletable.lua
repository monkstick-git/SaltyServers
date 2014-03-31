include("pulpscoreboard_elements/maintable_elements/infostable.lua")

local TitleTable = {}

function TitleTable:Init() 
	local image = vgui.Create("DImage", self)
	image:SetPos(0, 0)
	image:SetSize(self:GetWide()*0.25, self:GetTall())
	image:SetImage("materials/munmod/scoreboard/logo.png")
	
	image.PaintOver = function(self)
		surface.SetDrawColor(Color(255, 255, 255, 100))
		local w = self:GetWide()
		local h = self:GetTall()
		
		surface.DrawRect(0, 0, 2, h)
		surface.DrawRect(w-2, 0, 2, h)
		surface.DrawRect(0, 0, w, 2)
		surface.DrawRect(0, h-2, w, 2)
		
	end
	
	local infoTable = vgui.Create("PulpScoreboard_InfosTable", self)
	infoTable:SetPos(self:GetWide()*0.25+10, 0)
	infoTable:SetSize(self:GetWide()*0.75-10, self:GetTall())
	
	
	local temp = self.SetSize
	self.SetSize = function(...)
		local result = temp(...)
		image:SetSize(self:GetWide()*0.25, self:GetTall())
		infoTable:SetPos(self:GetWide()*0.25+10, 0)
		infoTable:SetSize(self:GetWide()*0.75-10, self:GetTall())
		return result
	end
end

function TitleTable:Paint()

end

vgui.Register("PulpScoreboard_TitleTable", TitleTable, "DPanel")