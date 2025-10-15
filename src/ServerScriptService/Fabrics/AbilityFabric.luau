--!strict
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local Interfaces = ServerScriptService.GeneratedInterfaces

local PackagesInterfaces = require(ReplicatedStorage.Interfaces.PackagesInterfaces)
local profilestore = require(ServerScriptService.ServerPackages.profilestore)

local DataComponentInterface = require(Interfaces:WaitForChild("DataComponentInterface"))
local WorldServiceInterface = require(Interfaces:WaitForChild("WorldServiceInterface"))
local ComponentFabricInterface = require(Interfaces:WaitForChild("ComponentFabricInterface"))

local JecsInterfaces = require(ReplicatedStorage.Interfaces.JecsInterfaces)

local AbilityFabric = {}

AbilityFabric.Scope = "Singleton"
AbilityFabric.Inject = {
	ComponentFabric = "ComponentFabric",
	WorldService = "WorldService",
	Jecs = "Jecs",
}

export type Main = {
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

function AbilityFabric:RequestAbility()
	self = self :: Main
    local world = self.WorldService.World

    local testData = {
        id = 'test'
    }

    local entity = world:entity()
    world:set(entity, self.ComponentFabric.Components.Ability.Request, testData)

    return entity
end

function AbilityFabric:CreateAbility(entity: JecsInterfaces.Entity)
	self = self :: Main
    local world = self.WorldService.World

    local testData = {
        id = 'test',
        cooldown = 10,
    }

    world:set(entity, self.ComponentFabric.Components.Ability.Data, testData)
    --world:set(id, component, data)

    return entity
end

return AbilityFabric
