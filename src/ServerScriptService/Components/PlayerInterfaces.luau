local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Interfaces = ReplicatedStorage:WaitForChild("Interfaces")
local Templates = ReplicatedStorage:WaitForChild("Templates")

local EntityInterfaces = require(Interfaces:WaitForChild("EntityInterfaces"))
local ProfileTemplate = require(Templates:WaitForChild("DataProfile"))

type IProfile = typeof(ProfileTemplate())
type IEntityComponent = EntityInterfaces.IEntityComponent

export type IServerPlayerComponent = IEntityComponent & {
	Instance: Player,
	Profile: IProfile,
}

return {}
