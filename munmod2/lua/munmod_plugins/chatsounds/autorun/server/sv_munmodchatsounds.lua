function isStartTyping(ply,msg,_) 
	if (not ply.MunModChatSpam) then ply.MunModChatSpam = 0 end
	if (not ply.MunModNumberOfSpam) then ply.MunModNumberOfSpam = 0 end
	local Message = string.Explode(" ",msg)

	if(ply.MunModChatSpam < 3) then
		ply.MunModHasSpammed = 0
		local Help = {"help","halp","help!"}
		local HelpSounds = {"vo/ravenholm/monk_helpme02.wav","vo/ravenholm/monk_helpme04.wav","vo/ravenholm/monk_helpme05.wav"}
			if (table.HasValue(Help,string.lower(Message[1])) or table.HasValue(Help,string.lower(Message[table.Count(Message)]))) then
				sound.Play(table.Random(HelpSounds),ply:GetPos(),100)
					if(ply.MunModChatSpamOld) then
						if((os.time()-ply.MunModChatSpamOld) <= 3) then
							--ply.MunModChatSpam = ply.MunModChatSpam + 1
						end
					end
			end
		local No = {"no","nah","no!"}
		local NoSounds = {"vo/citadel/eli_notobreen.wav"}
			if (table.HasValue(No,string.lower(Message[1])) or table.HasValue(No,string.lower(Message[table.Count(Message)]))) then
				sound.Play(table.Random(NoSounds),ply:GetPos(),100)
					if(ply.MunModChatSpamOld) then
						if((os.time()-ply.MunModChatSpamOld) <= 3) then
							--ply.MunModChatSpam = ply.MunModChatSpam + 1
						end
					end
			end
		local Alright = {"kk","alright","yes","yeah","ok","sure","sure!","yes!","yeah?"}
		local AlrightSounds = {"vo/citadel/al_yes_nr.wav","vo/npc/vortigaunt/yes.wav","vo/npc/vortigaunt/certainly.wav"}
			if (table.HasValue(Alright,string.lower(Message[1])) or table.HasValue(Alright,string.lower(Message[table.Count(Message)]))) then
				sound.Play(table.Random(AlrightSounds),ply:GetPos(),100)
					if(ply.MunModChatSpamOld) then
						if((os.time()-ply.MunModChatSpamOld) <= 3) then
							--ply.MunModChatSpam = ply.MunModChatSpam + 1
						end
					end
			end
		local Laugh = {"lol","hah","haha","xd","rofl","hehe","lawl","lmao"}
		local LaughSounds = {"npc/metropolice/vo/chuckle.wav","vo/npc/barney/ba_laugh01.wav","vo/npc/barney/ba_laugh02.wav","vo/npc/barney/ba_laugh03.wav","vo/npc/barney/ba_laugh04.wav","vo/ravenholm/madlaugh01.wav","vo/ravenholm/madlaugh02.wav","vo/ravenholm/madlaugh03.wav","vo/ravenholm/madlaugh04.wav"}
			if (table.HasValue(Laugh,string.lower(Message[1])) or table.HasValue(Laugh,string.lower(Message[table.Count(Message)]))) then
				sound.Play(table.Random(LaughSounds),ply:GetPos(),100)
					if(ply.MunModChatSpamOld) then
						if((os.time()-ply.MunModChatSpamOld) <= 3) then
							--ply.MunModChatSpam = ply.MunModChatSpam + 1
						end
					end
			end
		ply.MunModChatSpamOld = os.time()
		else
			if(ply.MunModHasSpammed == 1) then
			else
				ply.MunModHasSpammed = 1
				ply.MunModNumberOfSpam = ply.MunModNumberOfSpam + 1
				MunModTable.addChat(nil, team.GetColor(ply:Team())," "..ply:Nick(),Color(200,200,200)," chat sounds have been automatically muted for ",Color(255,0,0),tostring(ply.MunModNumberOfSpam*60),Color(200,200,200)," seconds due to spam!")
				timer.Simple(60*ply.MunModNumberOfSpam,function() ply.MunModChatSpam = 0 MunModTable.addChat(nil,ply:Nick().."'s chat sounds have un-muted!") end)
			end 
	end
end




hook.Add("PlayerSay", "HasStartedTyping", isStartTyping )