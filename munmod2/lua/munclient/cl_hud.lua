local munmod
local munmodshouldpaint = false
local countDown = 60
local munmodtimer = {}
local munmodevent = ""
local Invert = 255
local TIME = 60
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

function munmodpaint() 
	if (munmodshouldpaint) then
		if(TIME > 2) then TIME = TIME - 1 end
		surface.SetFont("MunModFont")
		Invert = math.mod(CountDown,2) * 255
		draw.WordBox(16,ScrW() / 2 - (surface.GetTextSize(munmodevent)/2), ( (ScrH() / 12) - (TIME*5)),tostring(munmodevent),"MunModFont",Color( Invert*2, Invert*2, Invert*2, 100 ), Color( 100,100,255,255 ))
	end
end

function munmodrecievetimer()
	TIME = 120
	munmodtimer = net.ReadTable()
		if(string.len(munmodtimer[1]) <= 0) then
			munmodtimer=60
		end
		
	CountDown = tonumber(munmodtimer[1])
	munmodshouldpaint = true
	munmodevent = ("Changing maps to "..tostring(munmodtimer[2]).." in "..tostring(CountDown).." Seconds, SAVE YOUR THINGS!")
	timer.Create("munmodTimer",1,tonumber(munmodtimer[1]),muncountdown)
end

function muncountdown()
	CountDown = CountDown - 1
	munmodevent = ("Changing maps to "..tostring(munmodtimer[2]).." in "..tostring(CountDown).." Seconds, SAVE YOUR THINGS!")
end

function munmodclear()

local Bit = net.ReadBit()
	if(Bit) then
	print("TURNING OFF")
		munmodshouldpaint = false
		munmodevent = ""
		timer.Remove("munmodTimer")
		RunConsoleCommand("stopsound")
	end

end

function donations()
 local Frame = vgui.Create( "Frame" ); --Create a frame
    Frame:SetSize( ScrW(), ScrH() ); --Set the size to 200x200
    Frame:SetPos( 0, 0 ); --Move the frame to 100,100
    Frame:SetVisible( true );  --Visible
    Frame:MakePopup( );--Make the frame
HTMLTest = vgui.Create( "HTML",Frame )
HTMLTest:SetPos( 0,50 )
HTMLTest:SetSize( ScrW(), ScrH() - 200 )
HTMLTest:OpenURL( "http://fastdl.blueorifice.com/commands.txt" )
local button = vgui.Create( "Button",Frame )
        button:SetSize( 150,30 )
        button:SetPos(Frame:GetWide()/2,Frame:GetTall()-50)
        button:SetVisible( true )
        button:SetText( "Close" )
        function button:OnMousePressed()
            Frame:Remove()
        end
        function HTMLTest:OnMousePressed()
            Frame:MoveToFront()
			button:MoveToFront()
        end


end
concommand.Add("donate",donations)

hook.Add( "HUDPaint", "HelloThere",munmodpaint) 
net.Receive("munmod_clear",munmodclear)
net.Receive("munmod_timer",munmodrecievetimer)
