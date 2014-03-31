hook.Add("Initialize", "PulpScoreboard", function()

	include("pulpscoreboard_server/vote.lua")
 
	-- Used to get the country clienstide
	util.AddNetworkString("sendCountry")
	net.Receive("sendCountry", function(len, client)
		if(client.country == nil) then 
			client.country = net.ReadString()
			client:SetNWString("country", client.country)
		end
	end) 
	
	local startTime = os.time()
	
	timer.Create("SetTime", 1, 0, function()
		game.GetWorld():SetNWInt("timeStarted",os.time()-startTime)
	end) 
		
	-- This function make the clients download all the folders and subfolders
	local function addAllFiles(path) 
		local f,d = file.Find(path.."/*","GAME")
		for _,v in pairs(f) do
			resource.AddSingleFile(path.."/"..v)
		end
		for _,v in pairs(d) do
			addAllFiles(path.."/"..v)
		end
	end
	
	-- Make the clients download all the flags, emoticons and fonts
	--addAllFiles("materials/countryicons16")
	--addAllFiles("materials/emoticons")
	--resource.AddSingleFile("resource/fonts/couture.ttf")
	--resource.AddSingleFile("materials/munmod/scoreboard/logo.png") 
	
	-- Make the client download the lua files
	AddCSLuaFile("autorun/client/cl_pulpscoreboard.lua")
	AddCSLuaFile("pulpscoreboard_elements/maintable.lua")
	AddCSLuaFile("pulpscoreboard_elements/maintable_elements/field.lua")
	AddCSLuaFile("pulpscoreboard_elements/maintable_elements/fieldpic.lua")
	AddCSLuaFile("pulpscoreboard_elements/maintable_elements/fieldtext.lua")
	AddCSLuaFile("pulpscoreboard_elements/maintable_elements/playerlist.lua")
	AddCSLuaFile("pulpscoreboard_elements/maintable_elements/row.lua")
	AddCSLuaFile("pulpscoreboard_elements/titletable.lua")
	AddCSLuaFile("pulpscoreboard_elements/maintable_elements/subinfos.lua")
	AddCSLuaFile("pulpscoreboard_elements/maintable_elements/infostable.lua")
	AddCSLuaFile("pulpscoreboard_elements/maintable_elements/subinfos_playercount.lua")
	AddCSLuaFile("pulpscoreboard_elements/maintable_elements/subinfos_description.lua")
	
	
end)


	
	
--end)
	