local chatCommands = {}

chatCommands.commands = {}

function chatCommands.addCommand(cmd, callback) 

	if(type(cmd) != "string") then
		error("First argument should be a string type value.")
	elseif(type(callback) != "function") then
		error("Second argument should be a function type value.")
	end

	chatCommands.commands[string.lower(cmd)] = callback

end

hook.Add("PlayerSay", "MunMod_ChatCommand", function (ply, msg)

	local prefix = msg[1]
	if(prefix != "!" and prefix != "/") then
		return
	end

	local splittedMsg = string.Split(string.sub(msg, 2), " ")

	local cmd = string.lower(splittedMsg[1] or "")
	if(cmd == "" or chatCommands.commands[cmd] == nil) then
		return
	end

	table.remove(splittedMsg, 1)

	chatCommands.commands[cmd](ply,splittedMsg);
	return ""

end)


MunModTable.chatCommands = chatCommands
