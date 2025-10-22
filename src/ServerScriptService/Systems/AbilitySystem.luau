--!strict

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")

local Interfaces = ReplicatedStorage:WaitForChild("Interfaces")

local BindableInterfaces = require(game.ServerScriptService.GeneratedInterfaces.BindableComponentInterface)
local ComponentFabricInterface = require(game.ServerScriptService.GeneratedInterfaces.ComponentFabricInterface)
local WorldServiceInterface = require(game.ServerScriptService.GeneratedInterfaces.WorldServiceInterface)

local ValidationRegistryInterface = require(game.ServerScriptService.GeneratedInterfaces.ValidationRegistryInterface)
local BehaviorRegistryInterface = require(game.ServerScriptService.GeneratedInterfaces.BehaviorRegistryInterface)

local JecsInterfaces = require(game.ReplicatedStorage.Interfaces.JecsInterfaces)

local AbilitySystem = {}
AbilitySystem.__index = AbilitySystem

AbilitySystem.Scope = "Singleton"
AbilitySystem.Inject = {
    BehaviorRegistry = "BehaviorRegistry",
    ValidationRegistry = "ValidationRegistry",
	BindableComponent = "BindableComponent",
	ComponentFabric = "ComponentFabric",
    WorldService = "WorldService"
}

export type Main = typeof(AbilitySystem)

type Dependencies = {
    BehaviorRegistry: BehaviorRegistryInterface.IBehaviorRegistry,
    ValidationRegistry: ValidationRegistryInterface.IValidationRegistry,
	BindableComponent: BindableInterfaces.IBindableComponent,
	ComponentFabric: ComponentFabricInterface.IComponentFabric,
    WorldService: WorldServiceInterface.IWorldService,
}

type self = Dependencies & Main

function AbilitySystem.new()
	local self = setmetatable({}, AbilitySystem)
	return self
end

function AbilitySystem:Init()
	self = self :: self
    local world = self.WorldService.World

    --add an update cycle somewhere
end

function AbilitySystem:ProcessRequest(entity: JecsInterfaces.Entity)
    self = self :: self
    local world = self.WorldService.World

    local requestData = world:get(entity, self.ComponentFabric.Components.Ability.StatusData)
    assert(requestData, `{entity} request data doesnt exist!`)

    local abilityEntity = requestData.entity

    local data = world:get(abilityEntity, self.ComponentFabric.Components.Ability.Data)
    assert(data, `{requestData.entity} ability data doesnt exist!`)

    for name, validation in pairs(data.validations) do
        if (validation.trigger ~= requestData.scope) then continue end
        local validationFunction = self.ValidationRegistry:Get(name)
        if (not validationFunction(validation.args, abilityEntity)) then return end
    end

    for name, behavior in pairs(data.behaviors) do
        if (behavior.trigger ~= requestData.scope) then continue end
        local behaviorFunction = self.BehaviorRegistry:Get(name)
        behaviorFunction(behavior.args, abilityEntity)
    end
end

function AbilitySystem:Update()
    self = self :: self
    local world = self.WorldService.World

    local validatedSignals: {JecsInterfaces.Entity} = {}

    -- either make a separate entity for each request or just create component in the existing entity

    for entity in world:query(self.ComponentFabric.Components.Ability.StatusData) do
        self:ProcessRequest(entity)
        table.insert(validatedSignals, entity)
    end

    for _, signal in pairs(validatedSignals) do
        world:delete(signal)
    end

end

return AbilitySystem
