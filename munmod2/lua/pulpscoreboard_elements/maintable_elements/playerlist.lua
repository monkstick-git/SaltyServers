include("pulpscoreboard_elements/maintable_elements/row.lua")

local PlayerList = {}

local playerHeight = 30 -- Height of the row

function PlayerList:Paint()

end

function PlayerList:Init()
	local temp = self.SetSize
	self.table = {}
	self.SetSize = function(...)
		local result = temp(...)
		
		for k,v in pairs(self.table) do
			if(IsValid(v.object)) then
				v.object:SetSize(self:GetWide(), playerHeight)
			end
		end
		return result
	end
end

function PlayerList:AddRow(ply)
	if(not IsValid(ply) or not ply:IsPlayer()) then return end
	local object = vgui.Create("PulpScoreboard_Row", self)
	object:SetSize(self:GetWide(), playerHeight);
	object:SetPos(0, (playerHeight+2)*(#self.table))
	object:SetInfos(ply)
	table.insert(self.table, {
								ply=ply,
								object = object
							 })
end
vgui.Register("PulpScoreboard_PlayerList", PlayerList, "DPanel")
