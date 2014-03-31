include("munmod_plugins/tab_server_information/panel/server.lua")

local tab = vgui.Create("MunMod_Tab_Server", tab)

MunModTable.gui:addTab("Server", tab, "icon16/computer.png", "General server information.")
