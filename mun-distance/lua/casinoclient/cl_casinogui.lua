surface.CreateFont( "MunModFont", {
font = "Arial",
size = 36,
weight = 1000,
blursize = 0,
scanlines = 0,
antialias = true,
underline = false,
italic = false,
strikeout = false,
symbol = false,
rotary = false,
shadow = false,
additive = false,
outline = false
} )

local MunFps = 1 
local MunFpsOld = 1
local Red = 50
local PropTable = {}
local APos = 0
local TableLength = 0
local ShouldDo = 0
local ShowFps = 0
local TimedFps = 1

hook.Add("OnPlayerChat","MunOnChat",function(ply,str)
	if(ply == LocalPlayer()) then
		if(str == "/autofps") then
			ShouldDo = 1
			chat.AddText("Attempting to get a constant 60 fps!")
		elseif(str == "/normalfps") then
			ShouldDo = 0
			chat.AddText("Fine, see if I care if you have low fps.")
			for k,v in pairs(ents.FindByClass("prop_*")) do
				v:SetNoDraw( false )
			end
		else
		end
		
		if(str == "/showfps") then
			ShowFps = 1
			chat.AddText("Showing FPS")
		elseif(str == "/hidefps") then
			ShowFps = 0
			chat.AddText("Hiding FPS")
		else
		
		end
		
	end
end)

timer.Create("GetAllProps",5,0,function()
	APos = 0
	PropTable = {}
	for k,v in pairs(ents.FindByClass("prop_*")) do
		table.insert(PropTable,v)
	end
	TableLength = table.Count(PropTable)
end)

timer.Create("GrabFps",0.01,0,function()
	if(MunFps < 40) then
		TimedFps = TimedFps - 1
	else
		TimedFps = TimedFps + 1
	end
	
	if(TimedFps < 1 ) then
		TimedFps = 1
	elseif(TimedFps >= 100) then
		TimedFps = 100
	else
	end
end)

timer.Create("RenderTest",0.01,0,function()
	if(ShouldDo == 1) then
		local orgin_ents = ents.FindInSphere(LocalPlayer():GetPos(), ( TimedFps * 40 ) )
		for I=1,10 do
			local Prop = PropTable[APos] 
				if(!table.HasValue(orgin_ents,Prop) and IsValid(Prop) and MunFps < 40) then
						Prop:SetNoDraw( true )
						--v:SetModelScale(0,0)
						Prop:DrawShadow(false)
				else
					if(IsValid(Prop)) then
						Prop:SetNoDraw( false )
						--v:SetModelScale(1,0)
						Prop:DrawShadow(false)
					end
				end
			if(APos < TableLength) then
				APos = APos+1
			else
			APos = 0
			end
		end
	end
end)

print("Test")

hook.Add("Tick","MunFpsTick",function()
	MunFps = ((1 / FrameTime()) + (MunFpsOld)) / 2 
	MunFpsOld = (1 / FrameTime()) 
	MunFps = math.floor(MunFps)
	if(MunFps > 15) then
	Red = 50
	else
	Red = 150
	end

end)

function PaintFps()
	if(ShowFps == 1) then
		draw.WordBox(16,ScrW() / 2 - (surface.GetTextSize(tostring(MunFps))/2), ( ScrH() / 12 ),tostring(MunFps) .. "  |  " .. tostring(TimedFps),"MunModFont",Color( Red, 50, Red, 100 ), Color( 255 - (MunFps * 4),MunFps * 4,0,255 ))
	else
	end
end

hook.Add( "HUDPaint", "GoPaintFps",PaintFps) 