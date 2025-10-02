local SessionData = {
	Instances = {},

	Attributes = {
		["Health"] = 100,
		["MaxHealth"] = 100,

		["WalkSpeed"] = 16,
		["JumpPower"] = 50,
	},

	CharacterData = {
		Character = nil :: Model?,
		Humanoid = nil :: Humanoid?,
		HumanoidRootPart = nil :: BasePart?,
	},

	StatusEffects = {
		Stun = false,
		iFrame = false,
		HyperArmor = false,
		Ragdoll = false,
	},

	Passives = {},

	Tasks = {},
	Threads = {},
}

return function(): typeof(SessionData)
	local clonned = table.clone(SessionData)
	clonned.Instances = {}
	clonned.Attributes = table.clone(SessionData.Attributes)
	clonned.CharacterData = table.clone(SessionData.CharacterData)
	clonned.StatusEffects = table.clone(SessionData.StatusEffects)
	return clonned
end
