PluginManager.plugins = {}
local loadedPlugins = {}
local pluginListString = util.TableToJSON({})

--[[

	Asks the client to reload all the plugins

]]--
util.AddNetworkString("MunMod_RefreshPlugins")
util.AddNetworkString("MunMod_RequestPlugins")
function PluginManager.refreshClPlugins()

	net.Start("MunMod_RefreshPlugins")
	net.Broadcast()

end

local function loadPlugin(name)

	table.insert(loadedPlugins, name)

	local requirements = PluginManager.plugins[name].require
	if(requirements and type(requirements) == "string" and #requirements > 0) then
		
		local tableRequire = string.Split(requirements, ";")
		for k,v in pairs(tableRequire) do
			if(PluginManager.plugins[v]) then
				
				if(!table.HasValue(loadedPlugins, v)) then
					
					loadPlugin(v)
					
				end

			else
				print("The required plugin (" .. v .. ") does not exist, skipping \"" .. name .."\" plugin")
				return
			end
		end

	end

	local pathToPlugin = PluginManager.pluginDirectoryPath .. "/" .. name
	-- Execute the luas in autorun and autorun/server

	-- Fuck logic. THATS WHY!!!!! (ask Pulp...)
	local function isDir(path, name)

		local _, dir = file.Find(path.."/*", "LUA")
		return table.HasValue(dir, name)

	end

	ServerLog(" - " .. pathToPlugin .. "\n")	
	if(file.IsDir(pathToPlugin .. "/autorun", "LUA")) then

		PluginManager.includeFiles(pathToPlugin .. "/autorun")

		if(isDir(pathToPlugin.."/autorun","server")) then

			PluginManager.includeFiles(pathToPlugin .. "/autorun/server")

		end

	end

end

--[[

	This function loads the plugins in the directory

]]--

function PluginManager.loadPlugins()

	ServerLog("[MunMod] Loading plugins...\n")

	local _, directories = file.Find( PluginManager.pluginDirectoryPath .. "/*", "LUA", "nameasc") 

	for k,v in pairs(directories) do

		local pathToPlugin = PluginManager.pluginDirectoryPath .. "/" .. v
		local m_info = PluginManager.loadPluginFile(pathToPlugin)

		if(m_info and m_info.name) then
			-- Register the plugin
			PluginManager.plugins[v] = m_info

		else
			ErrorNoHalt("No plugin.lua found in " .. v)
		end
	end


	for k,_ in pairs(PluginManager.plugins) do
		if(!table.HasValue(loadedPlugins, k)) then
			loadPlugin(k)
		end
	end

	pluginListString = util.TableToJSON(PluginManager.plugins)
	PluginManager.refreshClPlugins(pluginList)
end

PluginManager.loadPlugins()

MunModTable.pluginManager = PluginManger

util.AddNetworkString("MunMod_GetPlugins")
util.AddNetworkString("MunMod_PluginList")


net.Receive("MunMod_GetPlugins", function(_, ply)

	net.Start("MunMod_PluginList")

		net.WriteString(pluginListString)

	net.Send(ply)

end)