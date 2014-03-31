function MunModTable.getPropCount()

	return table.Count(ents.FindByClass("prop_physics"))

end

function MunModTable.getEntCount()

	return table.Count(ents.FindByClass("*"))

end

function MunModTable.getMemoryUsage()

	return math.floor(collectgarbage("count")) / 1024

end

function MunModTable.getFunctionCount()

	local funcCount = 0
	for _,v in pairs(debug.getregistry()) do
		
		if(type(v) == "function") then
			
			funcCount = funcCount + 1

		end

	end

	return funcCount 

end