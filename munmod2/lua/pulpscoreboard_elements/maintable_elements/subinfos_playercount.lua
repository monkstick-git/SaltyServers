local SubInfoPly = {}

function SubInfoPly:Init()
	self.botCount = vgui.Create("DLabel", self)
	local a = self.botCount

	a:SetText("")
	a:SetPos(0,self:GetTall()*(1-(1/0.8)*0.4)+1)
	a:SetSize(self:GetWide(), self:GetTall()*(1/0.8)*0.2-1)
	a:SetContentAlignment(5)
	
	local temp = self.SetSize
	self.SetSize = function(...)
		local result = temp(...)
		a:SetPos(0,self:GetTall()*(1-(1/0.8)*0.4)+1)
		a:SetSize(self:GetWide(), self:GetTall()*(1/0.8)*0.2-1)
		return result
	end
end


function SubInfoPly:SetBot(bots)
	self.botCount:SetText(bots)
end

vgui.Register("PulpScoreboard_SubInfo_PlayerCount", SubInfoPly, "PulpScoreboard_SubInfo")