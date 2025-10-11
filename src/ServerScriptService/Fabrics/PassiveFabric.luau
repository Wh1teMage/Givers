--!strict
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local Interfaces = ServerScriptService.GeneratedInterfaces

local PackagesInterfaces = require(ReplicatedStorage.Interfaces.PackagesInterfaces)

local WorldServiceInterface = require(Interfaces:WaitForChild("WorldServiceInterface"))

local PassiveFabric = {}

PassiveFabric.Scope = "Singleton"
PassiveFabric.Inject = {
	PassiveComponent = "PassiveComponent",
	WorldService = "WorldService",
	Jecs = "Jecs",
}

export type Main = {
	WorldService: WorldServiceInterface.IWorldService,
	Jecs: typeof(PackagesInterfaces.Jecs),
} & typeof(PassiveFabric)

function PassiveFabric.new()
	local self = setmetatable({}, { __index = PassiveFabric })
	return self
end

function PassiveFabric:CreatePassive(Type: string, Name: string, Level: number)
	local world = self.WorldService.World
	local entity = world:entity()

	local Data = {
		Type = Type,
		Name = Name,
		Level = Level,
	}

	world:set(entity, self.PassiveComponent.Data, Data)

	world:add(entity, self.PassiveComponent.Passive)

	return entity
end

return PassiveFabric
