--[[---------------------------------

	Create the top of the message

]]-----------------------------------

local logMsg = [[

 __  __             __  __           _ 
|  \/  |           |  \/  |         | |
| \  / |_   _ _ __ | \  / | ___   __| |
| |\/| | | | | '_ \| |\/| |/ _ \ / _` |
| |  | | |_| | | | | |  | | (_) | (_| |
|_|  |_|\__,_|_| |_|_|  |_|\___/ \__,_| v2.0

010011010111010101101110010011010110111101100100
================================================

Including serverside files : 

- autorun/sv_init.lua
]]



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

		logMsg = logMsg .. "- " .. args[1] .. "\n"
	
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
			logMsg = logMsg .. " - " .. path .. "\n"
		end

	end

	return oldInclude(...)

end
--[[------------------------------------------------------------------
	This function AddCSLuaFile every lua in folder or sub-folder
]]--------------------------------------------------------------------

local function addAllLuaFiles(path) 

	local f,d = file.Find(path.."/*","LUA")
	for _,v in pairs(f) do
		if(string.sub(v, #v-3) == ".lua") then
			AddCSLuaFile(path.."/"..v)
		end
	end
	for _,v in pairs(d) do
		addAllLuaFiles(path.."/"..v)
	end

end


local function includeAllFiles(path) 

	local f,d = file.Find(path.."/*","LUA")
	for _,v in pairs(f) do
		if(string.sub(v, #v-3) == ".lua") then
			include(path.."/"..v)
		end
	end
	for _,v in pairs(d) do
		includeAllFiles(path.."/"..v)
	end

end

-- Server files to open and run!
include("munshared/sh_munmodtable.lua")

-- Functions
include("munserver/sv_pulpmod_chatcommands.lua")-- Has to be included before the commands.
include("munserver/sv_pulpmod_logger.lua")
include("munserver/sv_pulpmod_serverfunctions.lua")

-- Hooks
include("munserver/hooks/sv_munmodleakdetection.lua")
include("munserver/hooks/sv_pulpmod_ent.lua")



-- Include plugin manager at the end.
logMsg = logMsg .. "\nLoading plugins :\n\n"

include("munshared/sh_pluginmanager.lua")
include("munserver/sv_pluginmanager.lua")

-- Client files to send
AddCSLuaFile( "autorun/client/cl_munmod_init.lua" )
addAllLuaFiles("munclient")
addAllLuaFiles("munshared")
resource.AddFile("resource/fonts/coolvetica.ttf")
resource.AddFile("resource/fonts/peach_milk.ttf")


--[[-----------------------------------------------------------------------------------------

	Prints the message & set the include function back to the original one

]]-------------------------------------------------------------------------------------------


logMsg = logMsg .. [[

=> [MunMod] loaded.

================================================
]]
print(logMsg)
include = oldInclude
