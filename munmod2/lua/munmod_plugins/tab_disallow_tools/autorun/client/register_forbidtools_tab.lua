include("munmod_plugins/tab_disallow_tools/panel/forbidtools.lua")

local tab = vgui.Create("MunMod_Tab_ForbidTools", tab)

MunModTable.gui:addTab("Tools", tab, "icon16/cancel.png", "Prevent players to use some tools.")
