--!strict

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Interfaces = ReplicatedStorage:WaitForChild("Interfaces")

local WorldServiceInterface = require(game.ServerScriptService.GeneratedInterfaces.WorldServiceInterface)

local ContainerInterface = require(game.ServerScriptService.GeneratedInterfaces.ContainerInterface)
local PlayerFabricInterface = require(game.ServerScriptService.GeneratedInterfaces.PlayerFabricInterface)

local PlayerSystem = {}
PlayerSystem.__index = PlayerSystem

PlayerSystem.Scope = "Singleton"
PlayerSystem.Inject = {
	PlayerFabric = "PlayerFabric",
	WorldService = "WorldService",
}

export type Main = {
	PlayerFabric: PlayerFabricInterface.IPlayerFabric,
	WorldService: WorldServiceInterface.IWorldService,
} & typeof(PlayerSystem)

function PlayerSystem.new()
	local self = setmetatable({}, PlayerSystem)
	return self
end

function PlayerSystem:Init()	
	self = self :: Main

	self.WorldService.EventBus:Connect("Player.Added", function(payload: {Player: Player})
		local entity = self.PlayerFabric:CreatePlayer(payload.Player)
		self.WorldService.EventBus:Fire("Player.Loaded", { Entity = entity })
	end)
end

return PlayerSystem
