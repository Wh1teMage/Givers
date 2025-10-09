--!strict

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Interfaces = ReplicatedStorage:WaitForChild("Interfaces")

local BindableInterfaces = require(game.ServerScriptService.GeneratedInterfaces.BindableComponentInterface)

local ContainerInterface = require(game.ServerScriptService.GeneratedInterfaces.ContainerInterface)
local PlayerFabricInterface = require(game.ServerScriptService.GeneratedInterfaces.PlayerFabricInterface)

local PlayerSystem = {}
PlayerSystem.__index = PlayerSystem

PlayerSystem.Scope = "Singleton"
PlayerSystem.Inject = {
	PlayerFabric = "PlayerFabric",
	BindableComponent = "BindableComponent",
}

export type Main = {
	PlayerFabric: PlayerFabricInterface.IPlayerFabric,
	BindableComponent: BindableInterfaces.IBindableComponent,
} & typeof(PlayerSystem)

function PlayerSystem.new()
	local self = setmetatable({}, PlayerSystem)
	return self
end

function PlayerSystem:Init()
	self = self :: Main

	self.BindableComponent:Connect("PlayerAdded", function(payload: {Player: Player})
		self.PlayerFabric:CreatePlayer(payload.Player)
	end)
end

return PlayerSystem
