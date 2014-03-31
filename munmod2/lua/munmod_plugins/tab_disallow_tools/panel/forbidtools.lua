
net.Receive("ForbiddenTools", function()

	hook.Call("Received_ForbiddenTool", {}, net.ReadTable())

end)

local PANEL = {}

function PANEL:refresh()

	net.Start("RequestForbiddenTools") net.SendToServer()

end

function PANEL:stopRefresh()

	for k,v in pairs(self.tools) do

		self.tools[k].ignore = true
		self.tools[k]:SetValue(0)

	end
	if(self.modified > 0) then
		self.modified = 0
		RunConsoleCommand("saveforbiddentools")
	end

end

function PANEL:setInfos(infos)
	
	for k,v in pairs(infos) do
		
		self.tools[k].ignore = true
		self.tools[k]:SetValue(1)

	end

end

function PANEL:Init()

	hook.Add("Received_ForbiddenTool", "MunMod_GUI", function(infos)

		self:setInfos(infos)

	end)

	self.modified = 0

	self.bg = vgui.Create("Panel", self)
	function self.bg:Paint()

		local w,h = self:GetSize()
		surface.SetDrawColor(Color(100,100,100,200))
		surface.DrawRect(0,0,w,h)

	end

	self.info = vgui.Create("DLabel", self)
	self.info:SetText("Check to disallow tools")
	self.info:SetColor(Color(255,255,255,255))
	self.info:SetFont("MunMod_GUI_Description")


	self.list = vgui.Create("DPanelList", self)
	--self.list:SetAutoSize(true)
	--self.list:SetAutoSize(5)
	self.list:EnableHorizontal(false)
	self.list:EnableVerticalScrollbar(true)

	self.tools = {}

	for k,v in pairs(weapons.Get("gmod_tool").Tool) do
		self.tools[k] = false
	end

	for k,v in SortedPairs(self.tools) do
		local tool = vgui.Create("DCheckBoxLabel")
		tool:SetText(k)
		tool:SizeToContents()
		function tool.OnChange(checkSelf,value) 

			if(checkSelf.ignore) then 
				checkSelf.ignore = nil
				return 
			end

			self.modified = 1

			if(value) then
				RunConsoleCommand("addforbiddentool", k)
			else
				RunConsoleCommand("removeforbiddentool", k)
			end

		end
		self.list:AddItem(tool)
		self.tools[k] = tool

	end

end

function PANEL:PerformLayout()

	local w,h = self:GetSize()

	self.info:SizeToContents()
	self.info:SetPos((w-self.info:GetWide())*0.5, h*0.05-self.info:GetTall()*0.5)

	self.bg:SetPos(w*0.123,h*0.1)
	self.bg:SetSize(w*0.76,h*0.85)

	self.list:SetPos(w*0.125,h*0.1)
	self.list:SetSize(w*0.75,h*0.85)

end

vgui.Register("MunMod_Tab_ForbidTools", PANEL, "Panel") 