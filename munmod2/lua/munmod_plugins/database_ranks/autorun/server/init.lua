local dbName_PlayerRank = "MunMod_PlayerRank"
local dbName_RankList = "MunMod_Ranks"

--sql.Query("DROP TABLE MunMod_Ranks")

function MunModTable.Database.getPlayerRank(ply)

	if(!(ply and IsValid(ply) and type(ply) == "Player" and ply:IsPlayer())) then
		return
	end

	local plySteamId64 = ply:SteamID64() or ""
	local value = sql.Query("SELECT rank FROM " .. dbName_PlayerRank .. " WHERE steamID64=\"" .. plySteamId64 .. "\"")
	
	if(value == false) then
		Error("SQL Error : " .. sql.LastError())
	elseif(value == nil) then
		return -1
	elseif(type(value) == "table" and #value >= 1) then

		local plyInfo = value[1]
		if(!plyInfo) then return end
		local plyTime = plyInfo.rank or 0
		return plyTime

	end

end

function MunModTable.Database.setPlayerRank(ply, rank)

	if(!(ply and IsValid(ply) and type(ply) == "Player" and ply:IsPlayer() and type(rank) == "number")) then
		return
	end
	local plySteamId64 = ply:SteamID64() or ""
	local value = sql.Query("SELECT * FROM " .. dbName_PlayerRank .. " WHERE steamID64=\"" .. plySteamId64 .. "\"")
	
	if(value == false) then
		Error("SQL Error : " .. sql.LastError())
	else
		local result = nil
		if(value == nil) then
			result = sql.Query("INSERT INTO " .. dbName_PlayerRank .. " (\"steamID64\",\"rank\") VALUES (\"" .. plySteamId64 .. "\", " .. rank .. ")")
		else
			result = sql.Query("UPDATE " .. dbName_PlayerRank .. " SET rank=" .. rank .. " WHERE steamID64=\"" .. plySteamId64 .. "\"")
		end

		if(result == false) then
			Error("SQL Error : " .. sql.LastError())
		end
	end

end

function MunModTable.Database.addRank(id, info)

	if(type(id) ~= "number" or type(info) ~= "table") then return end

	local jsonInfo = util.TableToJSON(info) or ""

	local result = sql.Query("SELECT * FROM " .. dbName_RankList .. " WHERE id=" .. id)

	if(result == nil) then
		
		result = sql.Query("INSERT INTO " .. dbName_RankList .. " (\"id\", \"information\") VALUES (" .. id .. "," .. sql.SQLStr(jsonInfo) .. ")")

		if(result == false) then
			Error("SQL Error: " .. sql.LastError())
		end
	else

		if(result == false) then
			
			Error("SQL Error: " .. sql.LastError())

		else

			Error("Another rank with the same ID already exists in the database.")

		end

	end

end

function MunModTable.Database.updateRank(id, info)

	if(type(id) ~= "number" or type(info) ~= "table") then return end
	
	local jsonInfo = util.TableToJSON(info) or ""

	local result = sql.Query("SELECT * FROM " .. dbName_RankList .. " WHERE id=" .. id)

	if(result == nil) then
		
		Error("There is no rank with this ID in the database.")

	else
		if(result) then
			result = sql.Query("UPDATE " .. dbName_RankList .. " SET information=" .. sql.SQLStr(jsonInfo) .. " WHERE id=" .. id)
		end
		if(result == false) then
			Error("SQL Error: " .. sql.LastError())
		end
	end
end

function MunModTable.Database.removeRank(id)

	if(type(id) ~= "number") then return end
	
	local result = sql.Query("SELECT * FROM " .. dbName_RankList .. " WHERE id=" .. id)

	if(result == nil) then
		
		Error("There is no rank with this ID in the database.")

	else
		if(result) then
			result = sql.Query("DELETE FROM " .. dbName_RankList .. " WHERE id=" .. id)
		end
		if(result == false) then
			Error("SQL Error: " .. sql.LastError())
		end
	end

end

function MunModTable.Database.getRanks()

	local result = sql.Query("SELECT * FROM " .. dbName_RankList)
	if(result == false) then
		Error("SQL Error: " .. sql.LastError())
	else
		return result
	end

end

if(!sql.TableExists(dbName_PlayerRank)) then
	

	print("No database created to store the ranks of the players, creating one.")
	local result = sql.Query("CREATE TABLE " .. dbName_PlayerRank .. "(steamID64  INTEGER, rank INTEGER)")

	if(result == false) then
		print("SQL Error :" .. sql.LastError())
	else
		print("The database has been created successfully.")
	end

end


if(!sql.TableExists(dbName_RankList)) then
	

	print("No database created to store the rank list, creating one.")
	local result = sql.Query("CREATE TABLE " .. dbName_RankList .. " (id INTEGER, information VARCHAR)")

	if(result == false) then
		print("SQL Error :" .. sql.LastError())
	else
		print("The database has been created successfully.")
		MunModTable.Database.addRank(0, {
			name = "Base rank",
			timeCreated = 0
		})
	end

end

local ranks = sql.Query("SELECT * FROM " .. dbName_RankList)
if(istable(ranks)) then

	if(table.Count(ranks) < 1) then
		
		local info = {
			name="Default rank", 
			default = true,
			timeCreated = os.time()

		}
		MunModTable.Database.addRank(util.CRC(info.name .. tostring(info.timeCreated)) , info)

	end

end
