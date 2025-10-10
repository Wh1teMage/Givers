local DataProfile = {
	Values = {
		["Gold"] = 0,
		["Experience"] = 0,
		["Level"] = 1,
	},

	Multipliers = {
		["Damage"] = 1,
		["Health"] = 1,
		["Experience"] = 1,
	},

	Inventory = {
		Equipment = {},
		Consumables = {},
		Resources = {},
	},
}

return function(): typeof(DataProfile)
	local clonned = table.clone(DataProfile)

	clonned.Values = table.clone(DataProfile.Values)
	clonned.Multipliers = table.clone(DataProfile.Multipliers)
	
	clonned.Inventory = {
		Equipment = {},
		Consumables = {},
		Resources = {},
	}

	return clonned
end
