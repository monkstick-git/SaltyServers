local PANEL = {}

function PANEL:Init()

	self:SetVisible(false);
	self.opened = 0;
	self.offsetX = 0
	self.alphaFlash = 0

	self.title = vgui.Create("DLabel", self);
	self.title:SetText("Muneris' Mod")
	self.title:SetFont("MunMod_GUI_Title")
	self.title:SetColor(Color(255,255,255,255))
	self.title:SizeToContents();

	function self.title:Paint() 
		surface.SetDrawColor(self.bgColor or Color(0,0,0,255)) 
		surface.DrawRect(0,0,self:GetWide(), self:GetTall()) 
	end

	function self.title:SetBGColor(color)
		self.bgColor = color
	end

	self.tabs = vgui.Create("DPropertySheet", self)

	local oldSetDrawColor = surface.SetDrawColor
	local setDrawColorAlpha = function(...)

		local args = {...}
		if(#args == 1) then
			args[1].a = args[1].a * self.alphaFlash
		elseif(#args == 4) then
			args[4] = args[4] * self.alphaFlash
		end
		
		return oldSetDrawColor(unpack(args))

	end

	local oldPaint = self.tabs.Paint or function() end
	function self.tabs.Paint(...)

		surface.SetDrawColor = setDrawColorAlpha

		local result = oldPaint(...)

		surface.SetDrawColor = oldSetDrawColor

		return result


	end

	local oldAddSheet = self.tabs.AddSheet 
	function self.tabs.AddSheet(...)

		local args = {...}
		local result = oldAddSheet(...)
		if(result and result.Panel and result.Tab) then
			
			local oldPaint = result.Panel.Paint or function() end
			/*result.Panel.Paint = function(...)
				surface.SetDrawColor = setDrawColorAlpha

				local result = oldPaint(...)

				surface.SetDrawColor = oldSetDrawColor

				return result
			end*//*
			oldPaint = result.Tab.Paint or function() end
			result.Tab.Paint = function(...)
				surface.SetDrawColor = setDrawColorAlpha

				local result = oldPaint(...)

				surface.SetDrawColor = oldSetDrawColor

				return result
			end*/

		end
		
		return result

	end


	self.tabs._SetActiveTab = self.tabs.SetActiveTab
	self.tabs.lastTab = nil

	self.tabs.SetActiveTab = function(...)

		local args = {...}

		if(!args[2] or !args[2]:GetPanel()) then
			return self.tabs._SetActiveTab(...)
		end
		local activeTab = self.tabs._SetActiveTab(...)

		if(IsValid(self.lastTab) and self.lastTab) then
			self.lastTab:GetPanel():stopRefresh()
		end

		args[2]:GetPanel():refresh();
		self.lastTab = args[2]

		return activeTab

	end

end

local tabList = {}
local emptyFunc = function() end
function PANEL:addTab(name, panel, icon, desc, x, y)

	if(type(name) ~= "string") then
		error("The first argument should be a string.")
	elseif(type(panel) ~= "Panel") then
		error("The second argument should be a Panel.")
	elseif(type(icon) ~= "string") then
		error("The third argument should be a string")
	elseif(type(desc) ~= "string") then
		error("The fourth argument should be a string.")
	elseif(type(x) ~= "boolean" and type(x) ~= "nil") then
		error("The fifth argument should be a boolean.")
	elseif(type(y) ~= "boolean" and type(y) ~= "nil") then
		error("The fifth argument should be a boolean.")
	end

	if(tabList[name]) then
		
		self.tabs:CloseTab(tabList[name], true)

	end

	x = x or false
	y = y or false

	tabList[name] = self.tabs:AddSheet(name, panel, icon, x, y, desc).Tab

	panel.refresh = panel.refresh or emptyFunc
	panel.stopRefresh = panel.stopRefresh or emptyFunc

end

function PANEL:SetOpened(open)

	if(open) then
		self.opened = CurTime();
		self:SetVisible(true)
		--self:SetPos(self.offsetX, self.fixedY)

		if(IsValid(self.tabs.lastTab)) then
			self.tabs.lastTab:GetPanel():refresh()
		end

		gui.EnableScreenClicker(true)

	else

		self.opened = 0;
		self:SetVisible(false)

		if(IsValid(self.tabs.lastTab)) then 
			self.tabs.lastTab:GetPanel():stopRefresh()
		end

		gui.EnableScreenClicker(false)

	end

end

function PANEL:PerformLayout()

	local w,h = self:GetSize()

	self.title:SetPos((w-self.title:GetWide())/2, h*0.07-self.title:GetTall()*0.5)
	self.tabs:SetPos(5, h*0.13+5)
	self.tabs:SetSize(w-10, h*0.87-10)
	--self.title:SetPos((w+50-titleX)/2, h*0.07-titleY*0.5)

end

function PANEL:PaintOver(w,h)

	surface.SetDrawColor(Color(255,255,255,255-self.alphaFlash*255))
	surface.DrawRect(0,0,w,h)

end

function PANEL:Think()

	self.alphaFlash = 1-math.Clamp(-(CurTime()-self.opened)*2+1,0,255)--math.Round(math.Clamp(1/(CurTime()-self.opened)*10,0,255))--255--self.offsetX/(wide+self.fixedX)


	local wide = self:GetWide()
	local tall = self:GetTall()

	--[[if(self.opened and self.offsetX < wide+self.fixedX) then

		self.offsetX = math.Clamp(self.offsetX + 15, 0, wide+self.fixedX)

	elseif(!self.opened and self.offsetX > 0) then
		
		self.offsetX = math.Clamp(self.offsetX - 15, 0, wide+self.fixedX)

	end

	self:SetPos(-wide+self.offsetX, self.fixedY)
--]]
	local alpha = self.alphaFlash
	self.title:SetBGColor(Color(0,0,0,255*alpha))
	self.title:SetColor(Color(255,255,255,255*alpha))
	self.tabs:SetFGColor(Color(255,255,255,255*alpha*0))

end

function PANEL:Paint()

	local wide = self:GetWide()
	local tall = self:GetTall()

	local alpha = self.alphaFlash

	surface.SetDrawColor(Color(200,200,200, alpha*200));
	surface.DrawRect(0, 0, wide, tall);

	surface.SetDrawColor(Color(50,50,50,alpha*225))
	surface.DrawRect(0, tall*0.02, wide, tall*0.1)
	surface.SetDrawColor(Color(255,255,255,alpha*225))
	surface.DrawRect(0, tall*0.02+2, wide, tall*0.1-4)

	--surface.SetDrawColor(Color(100,100,100,250*alpha))
	--surface.DrawRect(5, tall*0.13+5, wide-10,tall*0.87-10)

	surface.SetDrawColor(Color(50,50,50,250*alpha))
	surface.DrawRect(0,0,1,tall)
	surface.DrawRect(wide-1,0,1,tall)
	surface.DrawRect(0,0,wide,1)
	surface.DrawRect(0,tall-1,wide,1)
	
end

vgui.Register("MunMod_Menu", PANEL, "Panel") 
