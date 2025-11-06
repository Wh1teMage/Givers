--!strict

local ReplicatedStorage = game:GetService('ReplicatedStorage')
local Interfaces = ReplicatedStorage:WaitForChild('Interfaces')

local PackagesInterfaces = require(Interfaces.PackagesInterfaces)

local ContainerInterface = require(game.ServerScriptService.GeneratedInterfaces.ContainerInterface)
local BindableComponentInterface = require(game.ServerScriptService.GeneratedInterfaces.BindableComponentInterface)

local JecsInterfaces = require(game.ReplicatedStorage.Interfaces.JecsInterfaces)

local WorldService = {}
WorldService.__index = WorldService

WorldService.Scope = "Singleton"
WorldService.Inject = {
    BindableComponent = "BindableComponent",
	Container = "Container",
    Jecs = "Jecs",
}

export type Main = { 
    BindableComponent: BindableComponentInterface.IBindableComponent,
    Container: ContainerInterface.IContainer,
    Jecs: typeof(PackagesInterfaces.Jecs),
} & typeof(WorldService) & {
    World: JecsInterfaces.World,
    EventBus: BindableComponentInterface.IBindableComponent
}

function WorldService.new()
	local self = setmetatable({}, WorldService)
	return self
end

function WorldService:Init()
    self = self :: Main
    self.World = self.Jecs.world()
    self.EventBus = self.BindableComponent.new() :: any
end

return WorldService