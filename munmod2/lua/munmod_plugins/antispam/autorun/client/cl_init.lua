
local startTime = CurTime()
local timeLeft = 0


local function setTimeLeft(time)


	if(!img or !IsValid(img)) then
		
		local panel = vgui.Create("Panel")
		panel:SetSize(300,300)
		panel:Center()

		local img = vgui.Create("DImage", panel)
		img:SetImage("materials/munmod/antispam/redcross.png")
		function img:Think()

			local f = math.Clamp((startTime+timeLeft-CurTime())/timeLeft,0,1)
			img:SetSize(300*f, 300*f)
			img:Center()
			img:SetImageColor(Color(255,255,255,25+200*f))

			if(f <= 0) then
				panel:Remove()
			end

		end

	end

	timeLeft = time
	startTime = CurTime()
	GAMEMODE:AddNotify("[MunMod] You spawned too many props in a small amount of type, you can't spawn props for " .. time .. " second" .. (time>1 and "s" or ""), NOTIFY_ERROR, 7)

end

net.Receive("munmod_spamtimer", function()

	setTimeLeft(net.ReadInt(16))

end)
