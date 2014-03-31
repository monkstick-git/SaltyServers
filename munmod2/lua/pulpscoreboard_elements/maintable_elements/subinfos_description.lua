local SubInfoDesc = {}

function SubInfoDesc:Init()
	self.descLabel = vgui.Create("DLabel", self)
	local a = self.descLabel

	a:SetText("")
	a:SetSize(self:GetWide(), self:GetTall()*(1-(1/0.8)*0.2)-1)
	a:SetPos(self:GetWide()*0.02)
	a:SetContentAlignment(4)
	a:SetWrap(true)
	
	local temp = self.SetSize
	self.SetSize = function(...)
		local result = temp(...)
		a:SetPos(self:GetWide()*0.02)
		a:SetSize(self:GetWide()*0.96, self:GetTall()*(1-(1/0.8)*0.2)-1)
		return result
	end
end

function SubInfoDesc:SetDescription(desc)
	self.descLabel:SetText(desc)
end


vgui.Register("PulpScoreboard_SubInfo_Description", SubInfoDesc, "PulpScoreboard_SubInfo")