--!strict
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local Interfaces = ServerScriptService.GeneratedInterfaces

local PackagesInterfaces = require(ReplicatedStorage.Interfaces.PackagesInterfaces)
local profilestore = require(ServerScriptService.ServerPackages.profilestore)

local AbilityRegistryInterface = require(Interfaces:WaitForChild("AbilityRegistryInterface"))
local BehaviorRegistryInterface = require(Interfaces:WaitForChild("BehaviorRegistryInterface"))

local WorldServiceInterface = require(Interfaces:WaitForChild("WorldServiceInterface"))
local ComponentFabricInterface = require(Interfaces:WaitForChild("ComponentFabricInterface"))

local JecsInterfaces = require(ReplicatedStorage.Interfaces.JecsInterfaces)

local AbilityFabric = {}

AbilityFabric.Scope = "Singleton"
AbilityFabric.Inject = {
    AbilityRegistry = "AbilityRegistry",
	ComponentFabric = "ComponentFabric",
	WorldService = "WorldService",
	Jecs = "Jecs",
}

export type Main = {
    AbilityRegistry: AbilityRegistryInterface.IAbilityRegistry,
	ComponentFabric: ComponentFabricInterface.IComponentFabric,
	WorldService: WorldServiceInterface.IWorldService,
	Jecs: typeof(PackagesInterfaces.Jecs),
} & typeof(AbilityFabric)

function AbilityFabric.new()
	local self = setmetatable({}, { __index = AbilityFabric })
	return self
end

function AbilityFabric:Init()
	self = self :: Main
end

function AbilityFabric:CreateAbility(name: string, ownerId: JecsInterfaces.Entity?, data: any)
	self = self :: Main
    local world = self.WorldService.World

    --separate this logic into different methods

    if (not data) then
        data = self.AbilityRegistry:Get(name)
        assert(data, `{name} ability doesnt exist!`)
    end

    local entity = world:entity()
    world:set(entity, self.ComponentFabric.Components.Ability.Data, data)

    -- check if this is correct
    if (ownerId) then
        world:set(ownerId, self.Jecs.pair(self.ComponentFabric.Components.Ability.HasAbility, entity))
    end

    return entity
end

return AbilityFabric
