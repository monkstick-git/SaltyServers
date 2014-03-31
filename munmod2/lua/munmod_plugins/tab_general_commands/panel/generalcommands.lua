local PANEL = {}

function PANEL:Init()

	self.list = vgui.Create("DPanelList", self)
	self.list:SetAutoSize(true)
	self.list:SetAutoSize(5)
	self.list:EnableHorizontal(false)
	self.list:EnableVerticalScrollbar(true)

	self.info = vgui.Create("DLabel", self)
	self.info:SetText("General commands")
	self.info:SetColor(Color(255,255,255,255))
	self.info:SetFont("MunMod_GUI_Description")

	self.plyDmg = vgui.Create("DCheckBoxLabel", self.list)
	self.plyDmg:SetText("Player damage")
	self.plyDmg:SizeToContents()

	self.plyDmg.ignore = false
	function self.plyDmg:OnChange(value) 
		if(self.ignore or false) then
			self.ignore = false
			return
		end

		if(value) then
			RunConsoleCommand("MunModServerDamage", "on")
		else
			RunConsoleCommand("MunModServerDamage", "off")
		end
	end

	self.list:AddItem(self.plyDmg)
end

function PANEL:PerformLayout()

	local w,h = self:GetSize()

	self.info:SizeToContents()
	self.info:SetPos((w-self.info:GetWide())*0.5, h*0.05-self.info:GetTall()*0.5)

	self.list:SetPos(w*0.125,h*0.1)
	self.list:SetSize(w*0.75,h*0.9)

end

function PANEL:refresh()

	self.plyDmg.ignore = true
	self.plyDmg:SetValue(GetGlobalBool("PlayerDamage", false) and 1 or 0)

end

function PANEL:stopRefresh()

end


vgui.Register("MunMod_Tab_GeneralCmds", PANEL, "Panel") 