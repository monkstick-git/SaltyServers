local databaseName = "MunMod_PlayerTime"


if(!sql.TableExists(databaseName)) then
	

	print("No database created to store the time of the players, creating one.")
	local result = sql.Query("CREATE TABLE " .. databaseName .. "(steamID64  INTEGER, time INTEGER)")

	if(result == false) then
		print("Error at creating the database. Error :" .. sql.LastError())
	else
		print("Database created.")
	end

end

function MunModTable.Database.registerPlayerTime(ply, time)

	if(!(ply and IsValid(ply) and type(ply) == "Player" and ply:IsPlayer() and type(time) == "number")) then
		return
	end
	local plySteamId64 = ply:SteamID64() or ""
	local value = sql.Query("SELECT * FROM " .. databaseName .. " WHERE steamID64=\"" .. plySteamId64 .. "\"")
	
	if(value == false) then
		Error("The time couldn't be retrieved. SQL Error : " .. sql.LastError())
	else
		local result = nil
		if(value == nil) then
			result = sql.Query("INSERT INTO " .. databaseName .. " (\"steamID64\",\"time\") VALUES (\"" .. plySteamId64 .. "\", " .. time .. ")")
		else
			result = sql.Query("UPDATE " .. databaseName .. " SET time=" .. time .. " WHERE steamID64=\"" .. plySteamId64 .. "\"")
		end

		if(result == false) then
			Error("The time couldn't be set. SQL Error : " .. sql.LastError())
		end
	end

end

function MunModTable.Database.getPlayerTime(ply) 

	if(!(ply and IsValid(ply) and type(ply) == "Player" and ply:IsPlayer())) then
		return
	end

	local plySteamId64 = ply:SteamID64() or ""
	local value = sql.Query("SELECT time FROM " .. databaseName .. " WHERE steamID64=\"" .. plySteamId64 .. "\"")
	
	if(value == false) then
		Error("The time couldn't be retrieved. SQL Error : " .. sql.LastError())
	elseif(value == nil) then
		return nil
	elseif(type(value) == "table" and #value >= 1) then

		local plyInfo = value[1]
		if(!plyInfo) then return end
		local plyTime = plyInfo.time or 0
		return plyTime

	end

end

function MunModTable.Database.addPlayerTime(ply, time)

	if(!(ply and IsValid(ply) and type(ply) == "Player" and ply:IsPlayer() and type(time) == "number")) then
		return
	end
	local plySteamId64 = ply:SteamID64() or ""
	local value = sql.Query("SELECT * FROM " .. databaseName .. " WHERE steamID64=\"" .. plySteamId64 .. "\"")
	
	if(value == false) then
		Error("The time couldn't be retrieved. SQL Error : " .. sql.LastError())
	else
		local result = nil
		if(value == nil) then
			result = sql.Query("INSERT INTO " .. databaseName .. " (\"steamID64\",\"time\") VALUES (\"" .. plySteamId64 .. "\", " .. time .. ")")
		else
			result = sql.Query("UPDATE " .. databaseName .. " SET time=time+" .. time .. " WHERE steamID64=\"" .. plySteamId64 .. "\"")
		end

		if(result == false) then
			Error("The time couldn't be set. SQL Error : " .. sql.LastError())
		end
	end

end
