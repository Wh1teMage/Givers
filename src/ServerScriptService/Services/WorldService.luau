--!strict

local ReplicatedStorage = game:GetService('ReplicatedStorage')
local Interfaces = ReplicatedStorage:WaitForChild('Interfaces')

local PackagesInterfaces = require(Interfaces.PackagesInterfaces)

local ContainerInterface = require(game.ServerScriptService.GeneratedInterfaces.ContainerInterface)
local JecsInterfaces = require(game.ReplicatedStorage.Interfaces.JecsInterfaces)

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
    World: JecsInterfaces.World
}

function WorldService.new()
	local self = setmetatable({}, WorldService)
	return self
end

function WorldService:Init()
    self = self :: Main

    self.World = self.Jecs.world()
end

return WorldService