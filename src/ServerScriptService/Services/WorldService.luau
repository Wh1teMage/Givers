--!strict

local ReplicatedStorage = game:GetService('ReplicatedStorage')
local Interfaces = ReplicatedStorage:WaitForChild('Interfaces')

local PackagesInterfaces = require(Interfaces.PackagesInterfaces)

local ContainerInterface = require(game.ServerScriptService.GeneratedInterfaces.ContainerInterface)

local WorldService = {}
WorldService.__index = WorldService

WorldService.Scope = "Singleton"
WorldService.Inject = {
	Container = "Container",
    Jecs = "Jecs"
}

export type Main = { 
    Container: ContainerInterface.IContainer,
    Jecs: typeof(PackagesInterfaces.Jecs),
} & typeof(WorldService) & {
    World: typeof(PackagesInterfaces.Jecs.World.new())
}

function WorldService.new()
	local self = setmetatable({}, WorldService)
	return self
end

function WorldService:Init()
    self = self :: Main

    self.World = self.Jecs.World.new()
end

return WorldService