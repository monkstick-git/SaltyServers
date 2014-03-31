local Field = {}

function Field:Init()
	self.textLabel = vgui.Create("DLabel", self)
	self.textLabel:SetSize(self:GetWide(), self:GetTall())
	self.textLabel:SetColor(Color(255,255,255,200))
	self.textLabel:SetFont("PulpScoreboard_couture" )
	self.textLabel:SetText("Z")
	
	self.image = vgui.Create("DImage", self)
	
	local temp = self.SetSize
	self.SetSize = function(...)
		local result = temp(...)  
		self.textLabel:SetSize(self:GetWide(), self:GetTall()) 
		self.image:SetPos(5,self:GetTall()/2-self.image:GetTall()/2)
		return result
	end
end
 
-- Add an image next to the text
function Field:SetImage(path, x, y) 
	if(path == "" and x == 0 and y ==0) then
		self.image:SetVisible(false)
	else
		self.image:SetVisible(true)
		self.image:SetImage(path)
		self.image:SetSize(x, y)
		self.image:SetPos(5,self:GetTall()/2-y/2)
	end
end	

function Field:AlignCenter()
	self.textLabel:SetContentAlignment(5)
end

function Field:SetText(text)
	self.textLabel:SetText(text)
end

function Field:SetColor(color)

	self.textLabel:SetColor(color)

end

vgui.Register("PulpScoreboard_FieldText", Field, "PulpScoreboard_BaseField")