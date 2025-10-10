--!strict

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Interfaces = ReplicatedStorage:WaitForChild("Interfaces")

local BindableInterfaces = require(game.ServerScriptService.GeneratedInterfaces.BindableComponentInterface)
local WorldServiceInterface = require(game.ServerScriptService.GeneratedInterfaces.WorldServiceInterface)
local PlayerComponentInterface = require(game.ServerScriptService.GeneratedInterfaces.PlayerComponentInterface)
local DataComponentInterface = require(game.ServerScriptService.GeneratedInterfaces.DataComponentInterface)

local JecsInterfaces = require(game.ReplicatedStorage.Interfaces.JecsInterfaces)

local CoinSystem = {}
CoinSystem.__index = CoinSystem

CoinSystem.Scope = "Singleton"
CoinSystem.Inject = {
	PlayerComponent = "PlayerComponent",
	DataComponent = "DataComponent",
    WorldService = "WorldService",
	BindableComponent = "BindableComponent",
}

export type Main = {
	PlayerComponent: PlayerComponentInterface.IPlayerComponent,
	DataComponent: DataComponentInterface.IDataComponent,
	BindableComponent: BindableInterfaces.IBindableComponent,
    WorldService: WorldServiceInterface.IWorldService,
} & typeof(CoinSystem)

function CoinSystem.new()
	local self = setmetatable({}, CoinSystem)
	return self
end

function CoinSystem:Init()
	self = self :: Main

	local world = self.WorldService.World

	self.BindableComponent:Connect("PlayerLoaded", function(payload: {Entity: JecsInterfaces.Entity})
		local profileLinkEntity = world:get(payload.Entity, self.PlayerComponent.ProfileLink)
		assert(profileLinkEntity, 'profile link doesnt exist!')

		print(world:get(profileLinkEntity, self.DataComponent.Data))
	end)
end

return CoinSystem
