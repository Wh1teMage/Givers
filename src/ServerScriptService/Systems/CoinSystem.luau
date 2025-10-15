--!strict

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Interfaces = ReplicatedStorage:WaitForChild("Interfaces")

local BindableInterfaces = require(game.ServerScriptService.GeneratedInterfaces.BindableComponentInterface)
local WorldServiceInterface = require(game.ServerScriptService.GeneratedInterfaces.WorldServiceInterface)
local PlayerComponentInterface = require(game.ServerScriptService.GeneratedInterfaces.PlayerComponentInterface)
local DataComponentInterface = require(game.ServerScriptService.GeneratedInterfaces.DataComponentInterface)
local ComponentFabricInterface = require(game.ServerScriptService.GeneratedInterfaces.ComponentFabricInterface)

local JecsInterfaces = require(game.ReplicatedStorage.Interfaces.JecsInterfaces)

local CoinSystem = {}
CoinSystem.__index = CoinSystem

CoinSystem.Scope = "Singleton"
CoinSystem.Inject = {
    WorldService = "WorldService",
	BindableComponent = "BindableComponent",
	ComponentFabric = "ComponentFabric",
}

export type Main = {
	BindableComponent: BindableInterfaces.IBindableComponent,
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
	
	self.BindableComponent:Connect("Player.Loaded", function(payload: {Entity: JecsInterfaces.Entity})
		local profile = world:target(payload.Entity, self.ComponentFabric.Components.Data.ProfileLink, 0)
		assert(profile, 'profile link doesnt exist!')

		print(world:get(profile, self.ComponentFabric.Components.Data.Data))
	end)
end

return CoinSystem
