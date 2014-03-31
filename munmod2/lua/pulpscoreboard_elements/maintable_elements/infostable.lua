include("pulpscoreboard_elements/maintable_elements/subinfos.lua")
include("pulpscoreboard_elements/maintable_elements/subinfos_playercount.lua")
include("pulpscoreboard_elements/maintable_elements/subinfos_description.lua")

local InfosTable = {}

local function getValuesTime(time)
	local days = math.floor(time/(60*60*24))
	local hours = math.floor((time-days*3600*24)/(60*60))
	local mins = math.floor((time-days*3600*24-hours*60*60)/60)
	local secs = math.floor((time-days*3600*24-hours*60*60 - mins*60))
	return days, hours, mins, secs
	
end

function InfosTable:Init()
	local upTime = vgui.Create("PulpScoreboard_SubInfo", self)
	upTime:SetPos(0,self:GetTall()*0.2+2)
	upTime:SetSize(self:GetWide()*0.25,self:GetTall()*0.8)
	upTime:SetTitle("Uptime")
	upTime.Think = function()
		local time = Entity(0):GetNWInt("timeStarted")
		local days, hours, minutes, seconds = getValuesTime(time)
		
		if(time < 3600) then
			upTime:SetText(minutes.."m "..seconds.."s")
		elseif(time<3600*24) then
			upTime:SetText(hours.."h "..minutes.."m")
		else
			upTime:SetText(days.."d "..hours.."h")
		end
	end

	local hostname = GetHostName() 
	
	local desc = vgui.Create("PulpScoreboard_SubInfo_Description", self)
	desc:SetPos(1*(self:GetWide()*0.25+2),self:GetTall()*0.2+2)
	desc:SetSize(self:GetWide()*0.5-1,self:GetTall()*0.8)
	desc:SetTitle("Description")
	desc:SetDescription("• You are currently playing on \""..hostname.."\" server on the map \""..game.GetMap().."\".\n")
	
	local plyCount = vgui.Create("PulpScoreboard_SubInfo_PlayerCount", self)
	plyCount:SetPos(3*(self:GetWide()*0.25+1),self:GetTall()*0.2+2)
	plyCount:SetSize(self:GetWide()*0.25-1,self:GetTall()*0.8)
	plyCount:SetTitle("Player count")
	plyCount.Think = function(self)
		self:SetText(#player.GetAll().." | "..game.MaxPlayers())
		local botCount = #player.GetBots()
		if(botCount==1) then
			self:SetBot("(1 bot spawned)")
		elseif(botCount>1) then
			self:SetBot("("..botCount.." bots spawned)")
		end
	end
	
	local title = vgui.Create("DLabel", self)
	title:SetText(hostname)
	title:SetFont("PulpScoreboard_couture2" )
	title:SetSize(self:GetWide(),self:GetTall()*0.2)
	title:SetContentAlignment(5)
	title:SetColor(Color(255,255,255,200))
	
	local temp = self.SetSize
	self.SetSize = function(...)
		local result = temp(...)
		upTime:SetPos(0,self:GetTall()*0.2+2)
		upTime:SetSize(self:GetWide()*0.25,self:GetTall()*0.8)
		
		desc:SetPos(1*(self:GetWide()*0.25+2),self:GetTall()*0.2+2)
		desc:SetSize(self:GetWide()*0.5-1,self:GetTall()*0.8)
		
		plyCount:SetPos(3*(self:GetWide()*0.25+1),self:GetTall()*0.2+2)
		plyCount:SetSize(self:GetWide()*0.25-1,self:GetTall()*0.8)
		
		title:SetSize(self:GetWide(),self:GetTall()*0.2)
		return result
	end
end

function InfosTable:Paint()
	surface.SetDrawColor(Color(0,0,0,150))
	surface.DrawRect(0,0,self:GetWide(),self:GetTall()*0.2)
end

vgui.Register("PulpScoreboard_InfosTable", InfosTable, "DPanel")