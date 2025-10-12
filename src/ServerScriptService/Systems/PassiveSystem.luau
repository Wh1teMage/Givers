--!strict

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Interfaces = ReplicatedStorage:WaitForChild("Interfaces")

local BindableInterfaces = require(game.ServerScriptService.GeneratedInterfaces.BindableComponentInterface)
local PassiveFabricInterface = require(game.ServerScriptService.GeneratedInterfaces.PassiveFabricInterface)
local WorldServiceInterface = require(game.ServerScriptService.GeneratedInterfaces.WorldServiceInterface)
local PassiveComponentInterface = require(game.ServerScriptService.GeneratedInterfaces.PassiveComponentInterface)

local PassiveSystem = {}
PassiveSystem.__index = PassiveSystem

PassiveSystem.Scope = "Singleton"
PassiveSystem.Inject = {
    BindableComponent = "BindableComponent",
    PassiveFabric = "PassiveFabric",
    WorldService = "WorldService",
    PassiveComponent = "PassiveComponent",
}

export type Main = {
    BindableComponent: BindableInterfaces.IBindableComponent,
    PassiveFabric: PassiveFabricInterface.IPassiveFabric,
    WorldService: WorldServiceInterface.IWorldService,
    PassiveComponent: PassiveComponentInterface.IPassiveComponent,
} & typeof(PassiveSystem)

function PassiveSystem.new()
    local self = setmetatable({}, PassiveSystem)
    return self
end

function PassiveSystem:Init()
    self = self :: Main
    local world = self.WorldService.World

    local TestPassive = self.PassiveFabric.CreatePassive(self.PassiveFabric :: any, 'Combat', 'Test', 1)
    local PassiveData = world:get(TestPassive,self.PassiveComponent.Data)
    
end


return PassiveSystem