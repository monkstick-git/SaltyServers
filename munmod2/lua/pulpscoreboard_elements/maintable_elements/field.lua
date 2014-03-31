local Field = {}

function Field:Paint()
	surface.SetDrawColor(Color(0,0,0,100+self.selectedV*100)) -- make it darker when selected
	surface.DrawRect(0, 0, self:GetWide(), self:GetTall())
end

Field.selectedV = 0
function Field:selected(yn)
	self.selectedV = yn
end

vgui.Register("PulpScoreboard_BaseField", Field, "DPanel")