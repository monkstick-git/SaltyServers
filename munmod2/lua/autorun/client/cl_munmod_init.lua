local function init()
	--[[---------------------------------

		Prints the top of the message

	]]-----------------------------------

	print(
	[[
 __  __             __  __           _ 
|  \/  |           |  \/  |         | |
| \  / |_   _ _ __ | \  / | ___   __| |
| |\/| | | | | '_ \| |\/| |/ _ \ / _` |
| |  | | |_| | | | | |  | | (_) | (_| |
|_|  |_|\__,_|_| |_|_|  |_|\___/ \__,_| v2.0

010011010111010101101110010011010110111101100100
================================================

Including clientside files : 

- autorun/cl_munmod.lua]])

	--[[----------------------------------------------------------------------------------

		Overrides the include function so it displays a message when a file is included.

	]]------------------------------------------------------------------------------------

	-- Save the original include function
	oldInclude = oldInclude or include

	include = function(...)

		local args = {...}

		if(!args[1]) then return oldInclude(...) end

		-- Checks if the file exists, if it does the include is probably relative to the lua folder
		if(file.Exists(args[1], "LUA")) then

			print("- " .. args[1])
		
		else

			-- Get the path of the file where include had been called
			local path = debug.getinfo(2).short_src

			-- Remove the "addons/munmod-2/lua" part and the end "yourFile.lua"
			local pathSplitted = string.Split(path, "/")
			table.remove(pathSplitted,1)
			table.remove(pathSplitted,1)
			table.remove(pathSplitted,1)
			table.remove(pathSplitted,#pathSplitted)

			-- Concat everything and add the relative path
			path = table.concat(pathSplitted, "/") .. "/" .. args[1]

			if(file.Exists(path, "LUA")) then
				print("- " .. path)
			end

		end

		return oldInclude(...)

	end

	--[[------------------------------------- 

		Includes every file needed

	]]---------------------------------------

	include("munshared/sh_munmodtable.lua")

	include("munclient/gui/main.lua")
	include("munclient/cl_hud.lua")
	include("munclient/logger.lua")

	print("\nLoading plugins :\n")
	include("munshared/sh_pluginmanager.lua")
	include("munclient/cl_pluginmanager.lua")

	--[[-----------------------------------------------------------------------------------------

		Prints the bottom of the message & set the include function back to the original one

	]]-------------------------------------------------------------------------------------------

	print([[

=> [MunMod] loaded.

================================================]])

	-- Reset the include function back to normal
	include = oldInclude 

	local editionTimeLuaFiles = {}

	local function isLuaFile(name)

		if(!isstring(name) or #name <= 3) then 

			return false

		elseif(string.sub(name, #name-3) == ".lua") then
			
			return true

		else

			return false

		end

	end

	local function checkAllLuas(path)

		local f,d = file.Find(path.."/*","LUA")

		for _,v in pairs(f) do

			local tempPath = path.."/"..v
			local timeFile = file.Time(tempPath, "LUA")

			if(!editionTimeLuaFiles[tempPath]) then

				editionTimeLuaFiles[tempPath] = timeFile

			elseif(isLuaFile(v) and editionTimeLuaFiles[tempPath] != timeFile) then
				
				include(tempPath)
				editionTimeLuaFiles[tempPath] = timeFile
				print("Reloading " .. tempPath)

			end
		
		end
		for _,v in pairs(d) do
			checkAllLuas(path.."/"..v)
		end

	end

	-- timer.Create("CheckAddonReload", 1, 0, function()

		-- checkAllLuas("munmod_plugins")
		-- checkAllLuas("munclient")

	-- end)
end
hook.Add("Initialize", "MunMod", init)


if(MunMod_Loaded) then init() end
MunMod_Loaded = CurTime()
