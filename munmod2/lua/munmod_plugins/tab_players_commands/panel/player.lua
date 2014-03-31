local PANEL = {}

net.Receive("MunMod_UpdatePlayerList", function()

	hook.Call("Received_PlayerList", {}, net.ReadTable())

end)

function PANEL:Init()

	hook.Add("Received_PlayerList", "MunMod_GUI", function(infos)

		self:setProps(infos)

	end)

	self.lastQuery = 0;

	self.labelInformation = vgui.Create("DLabel", self)
	self.labelInformation:SetText("Props information")
	self.labelInformation:SetFont("MunMod_GUI_Description")
	self.labelInformation:SetColor(Color(255,255,255,255))
	self.labelInformation:SizeToContents()

	self.propCount = vgui.Create("DLabel", self)
	self.propCount:SetText("Prop count :")
	self.propCount:SetFont("MunMod_GUI_DescriptionSmall")
	self.propCount:SetColor(Color(255,255,255,255))
	self.propCount:SizeToContents()

	self.averageProp = vgui.Create("DLabel", self)
	self.averageProp:SetText("Average props :")
	self.averageProp:SetFont("MunMod_GUI_DescriptionSmall")
	self.averageProp:SetColor(Color(255,255,255,255))
	self.averageProp:SizeToContents()

	self.propCountValue = vgui.Create("DLabel", self)
	self.propCountValue:SetText("0 prop")
	self.propCountValue:SetFont("MunMod_GUI_DescriptionSmall")
	self.propCountValue:SetColor(Color(255,255,255,255))
	self.propCountValue:SizeToContents()

	self.averagePropValue = vgui.Create("DLabel", self)
	self.averagePropValue:SetText("0 prop/player")
	self.averagePropValue:SetFont("MunMod_GUI_DescriptionSmall")
	self.averagePropValue:SetColor(Color(255,255,255,255))
	self.averagePropValue:SizeToContents()

	self.propPlayerList = vgui.Create("DListView", self)
	self.propPlayerList:AddColumn("Name")
	self.propPlayerList:AddColumn("Prop count")

end

function PANEL:PerformLayout()

	self.propCountValue:SizeToContents()
	self.averagePropValue:SizeToContents()

	self.labelInformation:SetPos(self:GetWide()/2-self.labelInformation:GetWide()/2, self:GetTall()*0.01)
	self.propCount:SetPos(self:GetWide()/2-self.propCount:GetWide()-5, self:GetTall()*0.05)
	self.averageProp:SetPos(self:GetWide()/2-self.averageProp:GetWide()-5, self.propCount:GetTall()+self:GetTall()*0.05)
	self.propCountValue:SetPos(self:GetWide()/2+5, self:GetTall()*0.05)
	self.averagePropValue:SetPos(self:GetWide()/2+5, self.propCount:GetTall()+self:GetTall()*0.05)

	local startPos = self.propCount:GetTall()+self:GetTall()*0.1

	self.propPlayerList:SetPos(0, startPos)
	self.propPlayerList:SetSize(self:GetWide(), self:GetTall()-startPos)

end

function PANEL:setProps(players) 

	if(!players) then return end

	local totalProp = 0
	local propPlayer = {}
	for k,v in pairs(player.GetAll()) do
		table.insert(propPlayer, {prop = (players[v] or 0), ply = v})
	end
	--PrintTable(propPlayer)
	--print("sort")
	table.SortByMember(propPlayer, "prop")
	--PrintTable(propPlayer)

	for _,v in pairs(propPlayer) do

		local ply = v.ply
		local playerId = ply:EntIndex()
		local playerEntId = ply:EntIndex()
		local line = self.propPlayerList:AddLine(ply:Nick(), v.prop)
		function line:OnMousePressed(mouse)
			
			if(mouse != MOUSE_RIGHT) then
				return
			end

			local menu = DermaMenu() 
			menu:AddOption( "Cleanup his props", function() 
				RunConsoleCommand("munmodcleanupprops", playerId) 
			end )
			menu:AddOption( "Freeze all props", function() 
				RunConsoleCommand("MunModFreeze", playerEntId)
			end ) 
			menu:AddOption( "Fab", function() 
				RunConsoleCommand("MunModFab", playerEntId) 
			end )
			menu:Open()

		end

		totalProp = totalProp + v.prop
	end
	local average = math.Round(totalProp / table.Count(propPlayer))

	self.propCountValue:SetText(totalProp .. " prop" .. (totalProp>1 and "s" or ""))
	self.averagePropValue:SetText(average .. " prop" .. (average>1 and "s" or "") .. "/player")

	self:InvalidateLayout()

end

function PANEL:refresh()

	net.Start("MunMod_GUI_Subscribe") 
		net.WriteInt(3,8)
	net.SendToServer()

end

function PANEL:stopRefresh()

	self.propPlayerList:Clear();
	net.Start("MunMod_GUI_UnSubscribe") 
		net.WriteInt(3,8)
	net.SendToServer()

end


vgui.Register("MunMod_Tab_Player", PANEL, "Panel") 