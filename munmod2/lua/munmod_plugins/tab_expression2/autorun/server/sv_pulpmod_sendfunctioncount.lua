local category = 2

util.AddNetworkString("MunMod_UpdateE2List")

local function getAllE2s()

	local e2s = {}
	
	for k,v in pairs(ents.FindByClass("gmod_wire_expression2")) do

		if(IsValid(v:CPPIGetOwner()) and v.context) then 

			table.insert(e2s, {
				owner = v:CPPIGetOwner():Nick(),
				ops = math.Round(v.context.prfbench or 0),
				name = v.name,
				ent = v,
			})

		end
	end

	return e2s

end

local function update(ply)

	net.Start("MunMod_UpdateE2List")
		net.WriteTable(getAllE2s())
	net.Send(ply)

end

hook.Add("MunMod_NewSubscription", "E2List", function(ply, plyCategory)

	if(plyCategory != category) then return end

	update(ply);

end)