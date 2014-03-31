PluginManager.plugins = {}

function PluginManager.loadPlugins()

	PluginManager.plugins = {}

	local _, directories = file.Find( PluginManager.pluginDirectoryPath .. "/*", "LUA", "nameasc") 

	for k,v in pairs(directories) do

		local pathToPlugin = PluginManager.pluginDirectoryPath .. "/" .. v

		-- Register the plugin
		PluginManager.plugins[v] = m_info		

		-- Fuck logic. THATS WHY!!!!! (ask Pulp...)
		local function isDir(path, name)

			local _, dir = file.Find(path.."/*", "LUA")
			return table.HasValue(dir, name)

		end


		-- Execute the luas in autorun and autorun/Broadcaster
		if(file.IsDir(pathToPlugin .. "/autorun", "LUA")) then

			PluginManager.includeFiles(pathToPlugin .. "/autorun")

			if(isDir(pathToPlugin.."/autorun","client")) then
				
				PluginManager.includeFiles(pathToPlugin .. "/autorun/client")

			end

		end

	end
end

net.Receive("MunMod_RefreshPlugins", function()

	PluginManager.loadPlugins()

end)


PluginManager.loadPlugins()
