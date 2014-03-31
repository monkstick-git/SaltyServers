include("pulpscoreboard_elements/maintable_elements/field.lua")
include("pulpscoreboard_elements/maintable_elements/fieldtext.lua")
include("pulpscoreboard_elements/maintable_elements/fieldpic.lua")


local PlayerRow = {} 
function PlayerRow:Init()
	self.country = vgui.Create("PulpScoreboard_FieldPic", self)
	self.name = vgui.Create("PulpScoreboard_FieldText", self)
	self.time = vgui.Create("PulpScoreboard_FieldText", self)
	self.time:AlignCenter()
	self.ping = vgui.Create("PulpScoreboard_FieldText", self)
	self.ping:AlignCenter() 
	self.like = vgui.Create("PulpScoreboard_FieldPic", self)
	self.teamField = vgui.Create("PulpScoreboard_FieldText", self)
	self.teamField:AlignCenter()
	
	local function resizeAllIcons()
		local tall = self:GetTall()
		local wide = self:GetWide()
		
		local lastY = wide-tall
		self.like:SetPos(lastY, 0)
		self.like:SetSize(tall, tall)
		
		lastY = lastY-2-tall*2
		self.ping:SetPos(lastY, 0)
		self.ping:SetSize(tall*2, tall)
		
		lastY = lastY-2-tall*2
		self.time:SetPos(lastY, 0)
		self.time:SetSize(tall*2, tall)
		
		lastY = lastY-2-tall*4.5
		self.teamField:SetPos(lastY,0)
		self.teamField:SetSize(tall*4.5, tall)
		
		local saveLastY = lastY
		lastY = tall+2
		self.name:SetPos(lastY, 0)
		self.name:SetSize(saveLastY-lastY-2, tall)
		
		lastY = 0
		self.country:SetPos(lastY, 0)
		self.country:SetSize(tall, tall)
	end
	resizeAllIcons()
	
	local temp = self.SetSize
	self.SetSize = function(...)
		local result = temp(...)
		resizeAllIcons()
		return result
	end
end

function PlayerRow:SetInfos(infos)
	self.ply = infos
	self.name:SetText("      "..infos:Nick())
	
	if(infos:IsMuted()) then 
		self.name:SetImage("icon16/sound_mute.png",16,16) 
	end
	
	local valueTime = 0
	if(self.ply.GetUTime and self.ply.GetUTimeStart) then
		
		valueTime = math.floor((self.ply:GetUTime() + CurTime() - self.ply:GetUTimeStart())/60/60)
	end
	self.time:SetText(valueTime)
	function self.ping:Think()
		if(IsValid(infos)) then
			self:SetText(infos:Ping().."")
		end
	end

	local plyTeam= infos:Team()
	self.teamField:SetText(team.GetName(plyTeam))
	self.teamField:SetColor(team.GetColor(plyTeam))
	
	local country = infos:GetNWString("country")
	if(country!="") then
		self.country:SetImage("materials/countryicons16/"..country..".png", 16*1.2, 11*1.2)
	else
		self.country:SetImage("icon16/world.png", 16, 16)
	end
	
	local likeField = self.like
	
	likeField:SetImage("icon16/emoticon_smile.png", 16, 16)
	likeField.Think = function()
		local rating = self.ply:GetNWInt("Rating") 
		if(rating == 1) then
			likeField:SetImage("materials/emoticons/devil.png",16,16)
		elseif(rating == 2) then 
			likeField:SetImage("materials/emoticons/sad.png",16,16)
		elseif(rating == 3 or rating == 0) then 
			likeField:SetImage("materials/emoticons/normal.png",16,16)
		elseif(rating == 4) then 
			likeField:SetImage("materials/emoticons/happy.png",16,16)
		elseif(rating == 5) then 
			likeField:SetImage("materials/emoticons/cool.png",16,16)
		end
		
		/* 
		Emoticons made by Farm-Fresh / Fatcow
		http://www.fatcow.com/free-icons
		*/
		
	end
end

function PlayerRow:Paint()
	
end

function PlayerRow:Think()
	if(IsValid(menuPulpScoreboard) and menuPulpScoreboard:IsVisible()) then return end

	local x,y = self:CursorPos()
	
	if(self.wasIn == nil) then
		if(x > 0 and y > 0 and x <= self:GetWide() and y <= self:GetTall())  then
			self.wasIn = true
			
			-- Make the field darker
			self.country:selected(1)
			self.name:selected(1)
			self.time:selected(1)
			self.ping:selected(1)
			self.like:selected(1)
			self.teamField:selected(1)
		end
	else
		if(not(x > 0 and y > 0 and x <= self:GetWide() and y <= self:GetTall()))  then
			self.wasIn = nil
			self.country:selected(0)
			self.name:selected(0)
			self.time:selected(0)
			self.ping:selected(0)
			self.like:selected(0)
			self.teamField:selected(0)
		else
			if(self.wasClicked == nil and input.IsMouseDown(MOUSE_RIGHT)) then
				self.wasClicked = true
				local ply = self.ply
				if(ply and IsValid(ply)) then
					menuPulpScoreboard = DermaMenu() 
					local menu =menuPulpScoreboard
					menu:AddOption( "Copy SteamID", function() 
						if(ply:IsBot()) then
							SetClipboardText("BOT")
						else
							SetClipboardText(ply:SteamID())
						end
					end)
					if(ply!=LocalPlayer()) then
						local muted = ply:IsMuted()
						if(muted) then
							menu:AddOption( "Unmute", function()
								ply:SetMuted(true)
								self.name:SetImage("",0,0)
							end)
						else 
							menu:AddOption( "Mute", function()
								ply:SetMuted(false)
								self.name:SetImage("icon16/sound_mute.png",16,16)
							end)
						end
						local ratings = menu:AddSubMenu( "Rate")
							ratings:AddOption(":D", function()
								RunConsoleCommand("pulp_rateplayer", ply:UniqueID(), 5)
							end)
							
							ratings:AddOption(":)", function() 
								RunConsoleCommand("pulp_rateplayer", ply:UniqueID(), 4)
							end)
							
							ratings:AddOption(":|", function() 
								RunConsoleCommand("pulp_rateplayer", ply:UniqueID(), 3)
							end)
							
							ratings:AddOption(":(", function() 
								RunConsoleCommand("pulp_rateplayer", ply:UniqueID(), 2)
							end)
							
							ratings:AddOption(">:[", function() 
								RunConsoleCommand("pulp_rateplayer", ply:UniqueID(), 1)
							end)
						end
					
					menu:Open()
				end
				
			elseif(not input.IsMouseDown(MOUSE_RIGHT)) then
				self.wasClicked = nil
			end
		end
	end
end

vgui.Register("PulpScoreboard_Row", PlayerRow, "DPanel")
