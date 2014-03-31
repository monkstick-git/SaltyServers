include("munmod_plugins/tab_pluginmanager/panel/plugin_manager.lua")

local tab = vgui.Create("MunMod_Tab_PluginManager", tab)

MunModTable.gui:addTab("Plugins", tab, "icon16/wrench.png", "Manage your plugins.")