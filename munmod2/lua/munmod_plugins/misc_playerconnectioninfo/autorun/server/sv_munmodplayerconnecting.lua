function MunModTable.OnPlayerHasConnected(ply)
	if(!ply.MunModSpawned) then
		MunModTable.addChat(nil,ply:Nick().." has joined the server!")
		ply.MunModSpawned = true
		ply.AcfDamage = true
	end
end

function MunModTable.Onplayerdisconnect(ply)
	ply.MunModSpawned = false
	MunModTable.addChat(nil,ply:Nick().. " has left the server." )
end

function MunModTable.Onplayerconnect(name,ip)
	MunModTable.addChat(nil,name.." is connecting to the server..." )
end

hook.Add("PlayerSpawn","MunModPlayerHasConnected",MunModTable.OnPlayerHasConnected)
hook.Add("PlayerConnect","MunModPlayerConnect",MunModTable.Onplayerconnect)
hook.Add("PlayerDisconnected","MunModPlayerDisconnected",MunModTable.Onplayerdisconnect)