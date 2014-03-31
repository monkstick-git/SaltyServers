net.Receive("MunMod_UpdateE2List", function()

	hook.Call("Received_UpdateE2List", {}, net.ReadTable())

end)

local PANEL = {}

function PANEL:Init()

	hook.Add("Received_UpdateE2List", "MunMod_GUI", function(e2list)

		self:setE2List(e2list)

	end)

	self.labelInformation = vgui.Create("DLabel", self)
	self.labelInformation:SetText("Expresssion 2 information")
	self.labelInformation:SetFont("MunMod_GUI_Description")
	self.labelInformation:SetColor(Color(255,255,255,255))
	self.labelInformation:SizeToContents()

	self.totalOps = vgui.Create("DLabel", self)
	self.totalOps:SetText("Total OPs :")
	self.totalOps:SetFont("MunMod_GUI_DescriptionSmall")
	self.totalOps:SetColor(Color(255,255,255,255))
	self.totalOps:SizeToContents()
	
	self.expression2Count = vgui.Create("DLabel", self)
	self.expression2Count:SetText("Expression2 count :")
	self.expression2Count:SetFont("MunMod_GUI_DescriptionSmall")
	self.expression2Count:SetColor(Color(255,255,255,255))
	self.expression2Count:SizeToContents()

	self.totalOpsValue = vgui.Create("DLabel", self)
	self.totalOpsValue:SetText("0 ops")
	self.totalOpsValue:SetFont("MunMod_GUI_DescriptionSmall")
	self.totalOpsValue:SetColor(Color(255,255,255,255))
	self.totalOpsValue:SizeToContents()
	
	self.expression2CountValue = vgui.Create("DLabel", self)
	self.expression2CountValue:SetText("0 chip")
	self.expression2CountValue:SetFont("MunMod_GUI_DescriptionSmall")
	self.expression2CountValue:SetColor(Color(255,255,255,255))
	self.expression2CountValue:SizeToContents()

	self.listE2 = vgui.Create("DListView", self)
	self.listE2:AddColumn("Owner")
	self.listE2:AddColumn("Name")
	self.listE2:AddColumn("OPs")

	self.lastQuery = 0

end

function PANEL:PerformLayout()

	self.totalOpsValue:SizeToContents()
	self.expression2CountValue:SizeToContents()

	self.labelInformation:SetPos(self:GetWide()/2-self.labelInformation:GetWide()/2, self:GetTall()*0.01)
	self.totalOps:SetPos(self:GetWide()/2-self.totalOps:GetWide()-5, self:GetTall()*0.05)
	self.expression2Count:SetPos(self:GetWide()/2-self.expression2Count:GetWide()-5, self.totalOps:GetTall()+self:GetTall()*0.05)
	self.totalOpsValue:SetPos(self:GetWide()/2+5, self:GetTall()*0.05)
	self.expression2CountValue:SetPos(self:GetWide()/2+5, self.totalOps:GetTall()+self:GetTall()*0.05)

	local startY = self.expression2Count:GetTall()+self.totalOps:GetTall()+self:GetTall()*0.1
	self.listE2:SetPos(0, startY)
	self.listE2:SetSize(self:GetWide(), self:GetTall()-startY)

end

function PANEL:refresh()

	net.Start("MunMod_GUI_Subscribe") 
		net.WriteInt(2,8)
	net.SendToServer()

end

function PANEL:stopRefresh()

	self.listE2:Clear()

	net.Start("MunMod_GUI_UnSubscribe") 
		net.WriteInt(2,8)
	net.SendToServer()

end

function PANEL:setE2List(e2)

	local totalOps = 0
	table.SortByMember(e2, "ops")
	for k,v in pairs(e2) do
		
		totalOps = totalOps + v.ops
		local e2Id = v.ent:EntIndex()
		local line = self.listE2:AddLine(v.owner, v.name, v.ops)

		function line:OnMousePressed(mouse)
			
			if(mouse != MOUSE_RIGHT) then
				return
			end

			local menu = DermaMenu() 
			menu:AddOption( "Halt execution", function() 
				RunConsoleCommand("halte2admin", e2Id) 
			end )
			menu:Open()

		end

	end

	self.totalOpsValue:SetText(totalOps .. " ops")
	
	local count = table.Count(e2)
	self.expression2CountValue:SetText(count .. " chip" .. (count>1 and "s" or ""))	
	self:InvalidateLayout();

end

vgui.Register("MunMod_Tab_Expression2", PANEL, "Panel") 