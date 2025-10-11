local Passive = {

	Data = {
		Type = "Default" :: string,
		Name = "Passive" :: string,
		Level = 1 :: number,
	},
}

return function(): typeof(Passive)
	local clonned = table.clone(Passive)

	clonned.Data = table.clone(Passive.Data)

	return clonned
end
