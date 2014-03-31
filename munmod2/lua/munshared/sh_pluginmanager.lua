PluginManager = {}
PluginManager.pluginDirectoryPath = "munmod_plugins"

--[[ 

	This function includes the files in the given directory (not in the sub folders)

]]
function PluginManager.includeFiles(path)
	
	local f = file.Find(path.."/*.lua","LUA")
	for _,v in pairs(f) do
		
		--local prefix = string.sub(v,1,3)
		local filePath = path.."/"..v

		include(filePath)
		
	end
end


--[[

	This function load the plugin file of the plugin, 
	if it does exists it returns a table with the information, 
	if it doesn't it returns nil.

]]--
function PluginManager.loadPluginFile(path)

	if(!path or !file.Exists(path.."/plugin.lua", "LUA")) then
		return
	end

	local info = file.Read(path.."/plugin.lua", "LUA")
	if(!info) then
		ErrorNoHalt("Error at retreiving info from plugin.lua file. (" .. path .. ")")
		return
	end 

	local infoTable = util.KeyValuesToTable(info)
	if(!infoTable) then
		ErrorNoHalt("Error at parsing plugin.lua file. (" .. path .. ")")
		return
	end

	return infoTable 

end
