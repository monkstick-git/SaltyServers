local Field = {}

function Field:Init()
	self.image = vgui.Create("DImage", self)
	self.image:SizeToContents()

	local temp = self.SetSize
	self.SetSize = function(...)
		local result = temp(...)
		if(self.image.size) then
			self.image:SetPos(self:GetWide()*0.5-self.image.size.x*0.5, self:GetTall()*0.5-self.image.size.y*0.5 )
		end
		return result
	end
end

function Field:SetImage(path, x, y)
	self.image:SetImage(path)
	self.image:SetSize(x, y)
	self.image.size = {x=x, y=y}
	self.image:SetPos(self:GetWide()*0.5-x*0.5, self:GetTall()*0.5-y*0.5 )
end

vgui.Register("PulpScoreboard_FieldPic", Field, "PulpScoreboard_BaseField")