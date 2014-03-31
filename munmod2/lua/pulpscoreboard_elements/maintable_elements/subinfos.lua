local SubInfo = {}

function SubInfo:Init()
	self.text = vgui.Create("DLabel", self)
	local text = self.text
	text:SetSize(self:GetWide(), self:GetTall()*(1-(1/0.8)*0.2)-1)
	text:SetFont("PulpScoreboard_couture2" )
	text:SetContentAlignment(5)
	text:SetColor(Color(255,255,255,200))
	text:SetText("")
	
	self.title = vgui.Create("DLabel", self)
	local title = self.title
	title:SetSize(self:GetWide(), self:GetTall()*(1/0.8)*0.2-1)
	title:SetFont("PulpScoreboard_couture" )
	title:SetContentAlignment(5)
	title:SetPos(0,self:GetTall()*(1-(1/0.8)*0.2)+1)
	title:SetColor(Color(255,255,255,200))
	title:SetText("")
	
	local temp = self.SetSize
	self.SetSize = function(...)
		local result = temp(...)
		text:SetSize(self:GetWide(), self:GetTall()*(1-(1/0.8)*0.2)-1)
		title:SetPos(0,self:GetTall()*(1-(1/0.8)*0.2)+1)
		title:SetSize(self:GetWide(), self:GetTall()*(1/0.8)*0.2-1)
		return result
	end
end

function SubInfo:Paint()
	surface.SetDrawColor(Color(0,0,0,75))
	surface.DrawRect(0,0,self:GetWide(), self:GetTall()*(1-(1/0.8)*0.2)-1)
	
	surface.SetDrawColor(Color(0,0,0,150))
	surface.DrawRect(0,self:GetTall()*(1-(1/0.8)*0.2)+1,self:GetWide(), self:GetTall()*(1/0.8)*0.2-1)
	
end 

function SubInfo:SetText(txt)
	self.text:SetText(txt)
end

function SubInfo:SetTitle(txt)
	self.title:SetText(txt)
end

vgui.Register("PulpScoreboard_SubInfo", SubInfo, "DPanel")