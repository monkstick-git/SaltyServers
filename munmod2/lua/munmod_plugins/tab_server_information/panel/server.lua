
net.Receive("MunMod_UpdateFunctionLeak", function()

	hook.Call("Received_FunctionLeak", {}, net.ReadInt(16))

end)

net.Receive("MunMod_UpdateMemoryLeak", function()

	hook.Call("Received_MemoryLeak", {}, net.ReadInt(32))

end)

net.Receive("MunMod_UpdateFunctionCount", function()

	hook.Call("Received_FunctionCount", {}, net.ReadInt(16))

end)

net.Receive("MunMod_UpdateRAM", function()

	hook.Call("Received_RAM", {}, net.ReadInt(32))

end)

net.Receive("MunMod_UpdatePropCount", function()

	hook.Call("Received_PropCount", {}, net.ReadInt(32))

end)

net.Receive("MunMod_UpdateEntCount", function()

	hook.Call("Received_EntCount", {}, net.ReadInt(32))

end)


local PANEL = {}


function PANEL:refresh()

	net.Start("MunMod_GUI_Subscribe") 
		net.WriteInt(1,8)
	net.SendToServer()

end

function PANEL:stopRefresh()

	net.Start("MunMod_GUI_UnSubscribe") 
		net.WriteInt(1,8)
	net.SendToServer()

end

function PANEL:Init()

	self.lastQuery = 0
	self.list = vgui.Create("DListView", self)
	self.list:AddColumn("Name")
	self.list:AddColumn("Value")

	self.list.ram = self.list:AddLine("Ram usage", 0)
	self.list.funcCount = self.list:AddLine("Functions count", 0)
	self.list.propCount = self.list:AddLine("Props count", 0)
	self.list.entCount = self.list:AddLine("Entities count", 0)
	self.list.memoryLeak = self.list:AddLine("Memory leak", 0)
	self.list.functionLeak = self.list:AddLine("Function leak", 0)

	hook.Add("Received_MemoryLeak", "MunMod_GUI", function(leak)

		self:setMemoryLeak(leak)

	end)
	hook.Add("Received_FunctionLeak", "MunMod_GUI", function(leak)

		self:setFunctionLeak(leak)

	end)
	hook.Add("Received_FunctionCount", "MunMod_GUI", function(count)

		self:setFunctionCount(count)

	end)
	hook.Add("Received_RAM", "MunMod_GUI", function(count)

		self:setRam(count)

	end)
	hook.Add("Received_PropCount", "MunMod_GUI", function(count)

		self:setPropCount(count)

	end)
	hook.Add("Received_EntCount", "MunMod_GUI", function(count)

		self:setEntCount(count)

	end)

end

function PANEL:PerformLayout()

	local w,h = self:GetSize()
	self.list:SetSize(w,h)

end

function PANEL:Paint()

	surface.SetDrawColor(Color(255,255,255,255))
	surface.DrawRect(0,0,self:GetWide(), self:GetTall())

end

function PANEL:setMemoryLeak(leak)

	self.list.memoryLeak:SetValue(2, leak .. " MB")

end

function PANEL:setFunctionLeak(leak)

	self.list.functionLeak:SetValue(2, leak .. " function" .. (leak>1 and "s" or ""))

end

function PANEL:setFunctionCount(leak)

	self.list.funcCount:SetValue(2, leak .. " function" .. (leak>1 and "s" or ""))

end

function PANEL:setRam(leak)

	self.list.ram:SetValue(2, leak .. " MB")

end

function PANEL:setPropCount(leak)

	self.list.propCount:SetValue(2, leak .. " prop" .. (leak>1 and "s" or ""))

end

function PANEL:setEntCount(leak)

	self.list.entCount:SetValue(2, leak .. " entit" .. (leak>1 and "ies" or "y"))

end


vgui.Register("MunMod_Tab_Server", PANEL, "Panel") 