
if(not sql.TableExists("player_rating")) then
	sql.Query("CREATE TABLE pulpscoreboard_rating(unique_id_rater varchar(255), unique_id_target varchar(255), vote int)")
end

local function getRatePlayer(ply) 
	if(not(IsValid(ply) and ply:IsPlayer())) then return end
	local query = sql.Query("SELECT * FROM pulpscoreboard_rating WHERE unique_id_target='"..ply:UniqueID().."'")
	if(not query or #query <1) then
		return 3
	else 
		local rate = 0
		for k,v in pairs(query) do
			rate = rate + v.vote
		end
		rate = rate/#query
		rate = math.Round(rate)
		return rate
	end
end

hook.Add("PlayerAuthed", "PulpScoreboard", function(ply)
	ply:SetNWInt("Rating", getRatePlayer(ply))
end)

local function ratePlayer(rater, ply, note) 
	local raterId = rater:UniqueID()
	local targetId = ply:UniqueID()
	local query = sql.Query("SELECT * FROM pulpscoreboard_rating WHERE unique_id_rater='"..raterId.."' AND unique_id_target='"..targetId.."'")

	if(query) then
		if(query[1].vote != note) then
			sql.Query("UPDATE pulpscoreboard_rating SET vote="..note.." WHERE unique_id_rater='"..raterId.."' AND unique_id_target='"..targetId.."'")
		end
	else
		sql.Query("INSERT INTO pulpscoreboard_rating ('unique_id_rater', 'unique_id_target', 'vote') VALUES ('"..raterId.."', '"..targetId.."', "..note..")")
	end
	ply:SetNWInt("Rating", getRatePlayer(ply))
end

--sql.Query("INSERT INTO pulpscoreboard_rating ('unique_id', 'a', 'b', 'c', 'd', 'e', 'lastVote') VALUES ('".. player.GetByID(1):UniqueID() .. "', 1,2,3,4,5,42)	")

concommand.Add("pulp_rateplayer", function(ply, _, args)
	local target = player.GetByUniqueID(args[1]) 
	if(not(IsValid(target) and target:IsPlayer() and IsValid(ply) and ply:IsPlayer() and ply!=target)) then return end
	
	local note = tonumber(args[2] or 0)
	ratePlayer(ply, target, note)
	
end, 
function() 
	local auto = {}
	for k,v in pairs(player.GetAll()) do
		table.insert(auto, "pulp_rateplayer "..v:UniqueID().." 5 ("..v:Nick()..")")
	end
	return auto
end, 

"This command is used to rate people on the server, do pulp_rateplayer [UNIQUEID] [RATING]  the rating must be between 1 and 5")