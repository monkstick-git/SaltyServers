	local LMT = {} -- A table to store our functions in.  LMT is short for LocalMunTable
	local MunModNow = os.date("%d-%m-%y") -- Makes todays date into a variable
	timer.Create("MunModCheckTheData",60,0,function() -- Every minute, change the date variable.  Should only change once a day.
		MunModNow = os.date("%d-%m-%y")
		LMT.CheckLogFiles()
	end)
	
	 -- Check if the folders exist, if not, create them -- 
	function LMT.CheckLogFiles()
		if(!file.IsDir("munmodlogs","DATA")) then
			file.CreateDir("munmodlogs","DATA")
			MunModTable.addChat(nil,"Creating MunModLogs folder... \n")
		end
		
		if(!file.IsDir("munmodlogs/chat","DATA")) then
			file.CreateDir("munmodlogs/chat","DATA")
			MunModTable.addChat(nil,"Creating MunModLogs folder... \n")
		end
		
		if(!file.IsDir("munmodlogs/props","DATA")) then
			file.CreateDir("munmodlogs/props","DATA")
			MunModTable.addChat(nil,"Creating MunModLogs/props folder... \n")
		end
		
		if(!file.IsDir("munmodlogs/tools","DATA")) then
			file.CreateDir("munmodlogs/tools","DATA")
			MunModTable.addChat(nil,"Creating MunModLogs/tools folder... \n")
		end
		
		if(!file.IsDir("munmodlogs/misc","DATA")) then
			file.CreateDir("munmodlogs/misc","DATA")
			MunModTable.addChat(nil,"Creating MunModLogs/misc folder... \n")
		end
		
		-- Check if the log files exist, if not, create them --
		
		
		if(!file.Exists("munmodlogs/chat/" .. MunModNow ..".txt","DATA")) then
			MunModTable.addChat(nil,MunModNow .. " chat/ does not exist, Creating... \n") 
			file.Write("munmodlogs/chat/" ..MunModNow..".txt","<!-- XML logs By Muneris of BlueOrifice-->\n<Messages>\n")  
			end

		if(!file.Exists("munmodlogs/props/" .. MunModNow ..".txt","DATA")) then
			MunModTable.addChat(nil,MunModNow .. " props/does not exist, Creating... \n")
			file.Write("munmodlogs/props/" ..MunModNow..".txt","Starting LogFile for: " .. MunModNow .. "\n")
		end

		if(!file.Exists("munmodlogs/tools/" .. MunModNow ..".txt","DATA")) then
			MunModTable.addChat(nil,MunModNow .. " tools/ does not exist, Creating... \n")
			file.Write("munmodlogs/tools/" ..MunModNow..".txt","Starting LogFile for: " .. MunModNow .. "\n")
		end
		
		if(!file.Exists("munmodlogs/misc/" .. MunModNow ..".txt","DATA")) then
			MunModTable.addChat(nil,MunModNow .. " misc/ does not exist, Creating... \n")
			file.Write("munmodlogs/misc/" ..MunModNow..".txt","Starting LogFile for: " .. MunModNow .. "\n")
		end
	end
	-- End of file and folder checking --
	
	-- This is the function that actually writes to file.  Don't call it directly, use MunModTable.WriteLog(String content , String file) (1 to 4)
	function LMT.WriteLog(str,arg)
		local RightNow = os.date("%X")
		file.Append( "munmodlogs/" .. arg .. "/" .. MunModNow .. ".txt",str .. "\n")
	end
	
	-- Our main function.  This accepts a string for file contense, and a string / number  to choose which file to log into --
	function MunModTable.WriteLog(str,arg)
		local Arg = tonumber(arg) or 4 -- Make out variable into a number, for consistancy and error checking
		
		if(Arg == 1) then
			LMT.WriteLog(str,"chat")
		elseif(Arg == 2) then
		elseif(Arg == 3) then
		elseif(Arg == 4) then
		else
		end
	end
	
	hook.Add("PlayerSay","MunLogsPlayerChat",function(ply,txt)
		local RightNow = os.date("%X")
		MunModTable.WriteLog("<Message>\n<Date>" .. RightNow .. "</Date>\n<IP>" .. ply:IPAddress() .."</IP>\n<SteamID>" ..ply:SteamID() .. "</SteamID>\n<From>" .. ply:Nick() .. "</From>\n<String>" .. txt .. "</String>\n</Message>\n",1)
		--MunModTable.addChat(nil,"said something") 
		return
	end)
	
	LMT.CheckLogFiles()