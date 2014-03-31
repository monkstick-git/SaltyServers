local PANEL = {}

local textLabel = "Plugin manager"

function PANEL:getPluginWhichRequire(thisPlugin)

	if(!isstring(thisPlugin)) then return end

	self.pluginsRequirement = self.pluginsRequirement or {}

	return self.pluginsRequirement[thisPlugin] or {}

end

function PANEL:Init()

	self.info = self:Add("DLabel")
	self.info:SetText(textLabel)
	self.info:SetColor(Color(255,255,255,255))
	self.info:SetFont("MunMod_GUI_Description") 

	self.tree = self:Add("DTree")
	self.plugins = self.tree:AddNode("Plugins")
	self.plugins.Icon:SetImage("icon16/package.png")

	local function deleteAllPanels(panel, delete)

		if(panel and panel.ChildNodes and panel.ChildNodes.GetChildren) then
			
			local children = panel.ChildNodes:GetChildren()

			for k,v in pairs(children) do
				
				deleteAllPanels(v, true)

			end

		end

		if(delete == true) then
			panel:Remove()
		end

	end

	function self.tree.Clear()

		local root = self.plugins
		deleteAllPanels(root)

	end

	self.pluginHerited = self:Add("DTree")
	self.root_requiredPlugins = self.pluginHerited:AddNode("Plugins required")
	self.root_parentPlugins = self.pluginHerited:AddNode("Plugins which require this one to work")

	function self.pluginHerited.Clear()

		local root = self.root_requiredPlugins
		deleteAllPanels(root)
		root = self.root_parentPlugins
		deleteAllPanels(root)

	end

	self.properties = self:Add("DProperties")

	local function addFieldsToTree(fields, curPlugin)

		if(fields.name) then 
			curPlugin:AddNode("Name : " .. fields.name, "icon16/tag_blue.png")
		end

		if(fields.description) then 
			curPlugin:AddNode("Description : " .. fields.description, "icon16/tag_green.png")
		end

		if(fields.author_name) then 
			curPlugin:AddNode("Author : " .. fields.author_name, "icon16/tag_red.png")
		end

		if(fields.require) then 
			curPlugin:AddNode("Plugins required : " .. string.gsub(fields.require, ";", ", "), "icon16/tag_pink.png")
		end

	end

	local function addPluginToTree(name, fields)

		local targetNode = self.plugins
			
		local curPlugin = targetNode:AddNode(name, "icon16/plugin.png")
		curPlugin.fields = fields
		curPlugin.name = name

		function curPlugin.DoClick()

			self:updateInformation(curPlugin.name,curPlugin.fields)

		end

		addFieldsToTree(fields, curPlugin)

	end

	net.Receive("MunMod_PluginList", function()

		self.pluginsRequirement = {}
		local str = net.ReadString() or ""
		local plugins = util.JSONToTable(str) or {}

		for name,fields in SortedPairs(plugins) do

			addPluginToTree(name, fields)
			if(fields.require) then
				
				local pluginsReq = string.Split(fields.require, ";")
				for _, v in pairs(pluginsReq) do
					
					self.pluginsRequirement[v] = self.pluginsRequirement[v] or {}
					table.insert(self.pluginsRequirement[v], name)

				end

			end

		end

		self.pluginList = plugins
		self.plugins:SetExpanded(true)


	end)

end

function PANEL:updateInformation(name, fields)

	self.pluginHerited.Clear()

	if(fields.require) then
		
		local plugins = string.Split(fields.require, ";")

		for _,v in pairs(plugins) do
			
			self.root_requiredPlugins:AddNode(v, "icon16/plugin_link.png")	

		end

	end

	self.root_requiredPlugins:SetExpanded(true)

	for k,v in pairs(self:getPluginWhichRequire(name) or {}) do
		self.root_parentPlugins:AddNode(v, "icon16/plugin_go.png")	
	end

	self.root_parentPlugins:SetExpanded(true)

end

function PANEL:PerformLayout()

	local w,h = self:GetSize()

	self.info:SizeToContents()
	local infoTall = self.info:GetTall()
	local posInfoX = w*0.32+(w*0.68-self.info:GetWide())*0.5
	local posInfoY = h*0.05-infoTall*0.5
	self.info:SetPos(posInfoX, posInfoY)

	self.tree:SetPos(w*0.01, h*0.01)
	self.tree:SetSize(w*0.3, h*0.98)

	self.pluginHerited:SetPos(w*0.33, h*0.79)
	self.pluginHerited:SetSize(w*0.66, h*0.2)


end

function PANEL:refresh()

	--PrintTable(self.tree:GetTable())
	net.Start("MunMod_GetPlugins") net.SendToServer()

end

function PANEL:stopRefresh()

	self.tree:Clear(true)	

end

surface.SetFont("MunMod_GUI_Description")
local _,heightPluginManagerLabel = surface.GetTextSize(textLabel)

function PANEL:Paint(w, h)

	surface.SetDrawColor(Color(255, 255, 255, 75))
	local z = h*0.05+heightPluginManagerLabel*1.5
	surface.DrawRect(w*0.32, 5, w*0.68, z-10)
	
	surface.SetDrawColor(Color(200, 200, 200, 75))
	surface.DrawRect(w*0.32, z+5, w*0.68, h-z-5)

	surface.SetDrawColor(Color(255, 255, 255, 100))
	surface.DrawRect(w*0.32, z+5+2, 2, h-z-4)
	surface.DrawRect(w*0.32+w*0.68-2, z+5+2, 2, h-z-4)
	surface.DrawRect(w*0.32, z+5, w*0.68, 2)
	surface.DrawRect(w*0.32, h-2, w*0.68, 2)


end

vgui.Register("MunMod_Tab_PluginManager", PANEL, "Panel") 