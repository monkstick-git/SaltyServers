MsgAll("Script is actually running")

util.AddNetworkString("munmod_timer")
util.AddNetworkString("munmod_clear")
local MunModStarted = 0
local MunModTimeLeft = 0
local MunModShouldTimer = false
local MunModMap = ""

function MunModTable.WriteMaps()
local MapTable = {}
for k,v in pairs (file.Find("maps/gm_*.bsp","GAME")) do
	table.insert(MapTable,v)
end
file.Write("munmodmaplist.txt",util.TableToJSON(MapTable))
end

function MunModTable.FindRandomMap() 
if not file.Exists("munmodmaplist.txt","DATA") then MunModTable.WriteMaps() return game.GetMap()  end
local MapList1 = util.JSONToTable(file.Read("munmodmaplist.txt","DATA"))
local Map1 = table.Random(MapList1)
return Map1
end

function MunModTable.ChangeLevel2()
	local rndmap = string.Replace(MunModTable.FindRandomMap(),".bsp","") 
	local changetime = 600
	MunModTable.addChat(nil,"Changing maps to ",Color(0,200,0),rndmap,Color(200,200,200)," in "..changetime.." seconds!")
	MunModShouldTimer = true
	local timerint = changetime
	local mapstring = rndmap
		local NetTable = {timerint,mapstring}
		net.Start("munmod_timer")
		net.WriteTable(NetTable)
		net.WriteBit(true)
		net.Broadcast()
	MunModMap = mapstring
	MunModTimeLeft = tonumber(timerint)
	timer.Create("MunModServerTimer",tonumber(timerint),1,function() RunConsoleCommand("MunModChangeLevel",mapstring)end) 
	timer.Create("MunModNewTimer",1,tonumber(timerint),function() MunModTimeLeft = MunModTimeLeft - 1 	if(tonumber(MunModTimeLeft) == 30) then MsgAll("PLAYING SOUND") for k,v in pairs(player.GetAll()) do v:SendLua("surface.PlaySound( \"music/hl1_song25_remix3.mp3\" )") end end end) 
end

function MunModTable.ClientMessages(ply,_,args)
	MsgAll(ply)
	MunModShouldTimer = true
	if(!args[1]) then args[1] = "60" end
	if(!args[2]) then args[2] = game.GetMap() end
		local NetTable = {args[1],args[2]}
		net.Start("munmod_timer")
		net.WriteTable(NetTable)
		net.WriteBit(true)
		net.Broadcast()
	MunModMap = args[2]
	MunModTimeLeft = args[1]
	timer.Create("MunModServerTimer",args[1],1,function() RunConsoleCommand("MunModChangeLevel",args[2])end) 
	timer.Create("MunModNewTimer",1,args[1],function() MunModTimeLeft = MunModTimeLeft - 1 	if(tonumber(MunModTimeLeft) == 30) then MsgAll("PLAYING SOUND") for k,v in pairs(player.GetAll()) do v:SendLua("surface.PlaySound( \"music/hl1_song25_remix3.mp3\" )") end end end) 
end

concommand.Add("MunModStartTimer",MunModTable.ClientMessages)

function MunModTable.StopTimer()
	MunModShouldTimer = false
	net.Start("munmod_clear")
	net.WriteBit(true)
	net.Broadcast()
	timer.Remove("MunModServerTimer")
	timer.Remove("MunModNewTimer")
	for k,v in pairs(player.GetAll()) do v:ConCommand("stopsound") end
end

concommand.Add("MunModStopTimer",MunModTable.StopTimer)

function timerFunction(ply,args)
	if(ply:IsAdmin()) then	
		RunConsoleCommand("MunModStartTimer",args[1],args[2]) return
	end
end

function clearFunction(ply,args)
	RunConsoleCommand("MunModStopTimer") return
end

MunModTable.chatCommands.addCommand("timer", timerFunction) 
MunModTable.chatCommands.addCommand("clear", clearFunction)

function MunModTable.PlayerConnect()
	if(MunModShouldTimer) then
		local NetTable = {MunModTimeLeft,MunModMap}
		net.Start("munmod_timer")
		net.WriteTable(NetTable)
		net.WriteBit(true)
		net.Broadcast()
	end
end

-- timer.Create("CheckRealTime",10,0,function()
	-- if(RealTime() > 43200) then
		-- MunModTable.ChangeLevel2()
	-- end
-- end)
	

hook.Add("PlayerSpawn","munmodplayerconnect",MunModTable.PlayerConnect)