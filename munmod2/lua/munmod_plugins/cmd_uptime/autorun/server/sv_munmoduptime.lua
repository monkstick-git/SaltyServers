function MunModUpTime(player, strText, bTeamOnly, bPlayerIsDead)
local s = RealTime()
	local m = math.floor( s / 60 )
	s = math.fmod( s, 60 )
	local h = math.floor( m / 60 )
	m = math.fmod( m, 60 )
	local str = ""
	if h > 0 then str = tostring( h ) .. "hours " end
	if m > 0 then str = str .. tostring( m ) .. "min " end
	str = str .. tostring(  math.floor(s) ) .. "sec"

MunModTable.addChat(nil," Server uptime is: "..str)

end
concommand.Add( "MunModUpTime", MunModUpTime)

function uptimeFunction(_, _)
	RunConsoleCommand("MunModUpTime", "") return
end

MunModTable.chatCommands.addCommand("uptime", uptimeFunction)
