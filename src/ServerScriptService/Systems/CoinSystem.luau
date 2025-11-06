--!strict

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Interfaces = ReplicatedStorage:WaitForChild("Interfaces")

local WorldServiceInterface = require(game.ServerScriptService.GeneratedInterfaces.WorldServiceInterface)
local ComponentFabricInterface = require(game.ServerScriptService.GeneratedInterfaces.ComponentFabricInterface)

local JecsInterfaces = require(game.ReplicatedStorage.Interfaces.JecsInterfaces)

local CoinSystem = {}
CoinSystem.__index = CoinSystem

CoinSystem.Scope = "Singleton"
CoinSystem.Inject = {
    WorldService = "WorldService",
	ComponentFabric = "ComponentFabric",
}

export type Main = {
    WorldService: WorldServiceInterface.IWorldService,
	ComponentFabric: ComponentFabricInterface.IComponentFabric,
} & typeof(CoinSystem)

function CoinSystem.new()
	local self = setmetatable({}, CoinSystem)
	return self
end

function CoinSystem:Init()
	self = self :: Main

	local world = self.WorldService.World
	
	self.WorldService.EventBus:Connect("Player.Loaded", function(payload: {Entity: JecsInterfaces.Entity})
		local profile = world:target(payload.Entity, self.ComponentFabric.Components.Data.ProfileLink, 0)
		assert(profile, 'profile link doesnt exist!')

		print(world:get(profile, self.ComponentFabric.Components.Data.Data))
	end)
end

return CoinSystem
