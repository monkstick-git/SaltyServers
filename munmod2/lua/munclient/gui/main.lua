
include("fonts.lua")
include("mainframe.lua")

if(IsValid(MunModTable.gui)) then
	
	MunModTable.gui:Remove()

end


MunModTable.gui = vgui.Create("MunMod_Menu")


MunModTable.gui:SetSize(ScrW()*0.6, ScrH()*0.75);
MunModTable.gui:SetPos(ScrW()*0.2, ScrH()*0.125);

local open = false

concommand.Add("munmod_gui", function()
	
	open = !open
	MunModTable.gui:SetOpened(open)

end)