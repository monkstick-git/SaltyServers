function MunModTable.RankTable(ply)
local RankTable = {"Emperor: Owner", "VIP: Donator", "Admin", "Regent: Advanced Builder - 150 Hours", "Duke: Builder - 100 Hours", "Earl: Advanced Regular - 50 Hours", "Baron: Regular - 25 Hours","Commoner - 13 Hours", "Yeoman: User - 5 Hours", "Peasant: Guest"}
	for k,v in pairs(RankTable) do
		MunModTable.addChat(ply,RankTable[k])
	end
	return false
end


concommand.Add("MunModRanks",MunModTable.RankTable)

function ranksFunction(_, _)
RunConsoleCommand("MunModRanks", "") return
end

MunModTable.chatCommands.addCommand("ranks", ranksFunction)
