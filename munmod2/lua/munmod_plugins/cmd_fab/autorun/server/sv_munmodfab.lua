function MunModTable.Fab(ply,_,args)
if(!IsValid(ply) or ply:IsAdmin() or ply:EntIndex() == tonumber(args[1])) then
	local Player = ply -- Dont mess with
	local Target = "Nobody" -- Dont mess with
	if(tostring(args[1])=="*") then Target = "*" else if(args[1]==nil) then Target = ply:EntIndex() else Target = args[1] end end -- Checks whether or not * is the arg
		if(Target != "*") then -- if its not, then it must be a player
			for k,v in pairs (ents.FindByClass("prop_physics")) do
				if(v:CPPIGetOwner()) then -- if there is an fpp owner, carry on
					if (v:CPPIGetOwner():EntIndex() == tonumber(Target)) then -- If the ent index of the owner of the prop is the same as our args, carry on 
						v:SetColor(Color(math.random(0,255),math.random(0,255),math.random(0,255))) -- Randomly set the colour
					end 
				end
			end
			MunModTable.addChat(nil,"Made "..player.GetByID(Target):Nick().."'s props look Fabulous!")
			return
		end
		
	if(Target == "*") then -- If the arg was * (All players)
		for k,v in pairs (ents.FindByClass("prop_physics")) do -- Go nuts, Colour every prop on the map
			v:SetColor(Color(math.random(0,255),math.random(0,255),math.random(0,255)))
		end
		MunModTable.addChat(nil,Color(200,200,200),"Fabbed everybodys props!") -- ******Change this to the correct script
		return
	end
else
MunModTable.addChat(ply,Color(200,200,200),"You cannot use that command on that player!")
	end
end

concommand.Add("MunModFab",MunModTable.Fab)

function fabFunction(ply, args)
	local PlayerNumber = 0
	local PlayerIndex = 0
	if(not args[1]) then return end
	local targetName = string.lower(args[1])
		
	for k,v in pairs(player.GetAll()) do
			
		if(string.find(string.lower(v:Nick()),targetName)) then
			PlayerNumber = PlayerNumber + 1
			PlayerIndex = v:EntIndex()
		end		

	end
	
	if(PlayerNumber == 1) then
		if(ply:IsAdmin() or ply:EntIndex() == PlayerIndex) then
			RunConsoleCommand("MunModFab", PlayerIndex) return
		else
			MunModTable.addChat(ply,"You do not have permission to use this command on that player")
		end
	elseif(PlayerNumber > 1) then
		MunModTable.addChat(ply," Too many players found. Try refining the search criteria") return
	elseif(PlayerNumber == 0) then
		MunModTable.addChat(ply," No players found!") return
	end
	
end

MunModTable.chatCommands.addCommand("fab", fabFunction)
