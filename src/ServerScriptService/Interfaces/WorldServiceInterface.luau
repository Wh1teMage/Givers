--!strict

local ReplicatedStorage = game:GetService('ReplicatedStorage')
local Interfaces = ReplicatedStorage:WaitForChild('Interfaces')

local PackagesInterfaces = require(Interfaces.PackagesInterfaces)

export type IWorldService = {
    [any]: any,
    Jecs: typeof(PackagesInterfaces.Jecs),
    World: typeof(PackagesInterfaces.Jecs.World.new()),
	--Container: typeof(GlobalInterfaces.Container),
}


return {}
