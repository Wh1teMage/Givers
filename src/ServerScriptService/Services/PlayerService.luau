-- PlayerService.luau
--!strict
local ContainerInterface = require(game.ServerScriptService.GeneratedInterfaces.ContainerInterface)
local BindableInterfaces = require(game.ReplicatedStorage.Interfaces.BindableInterfaces)

local Players = game:GetService("Players")

local PlayerService = {}
PlayerService.__index = PlayerService

PlayerService.Scope = "Singleton"
PlayerService.Inject = {
	Container = "Container",
	BindableComponent = "BindableComponent"
}

export type Main = { 
	BindableComponent: BindableInterfaces.IBindableComponent,
    Container: ContainerInterface.IContainer,
} & typeof(PlayerService)

function PlayerService.new()
	local self = setmetatable({}, PlayerService)
	return self
end

function PlayerService:Init()
	self = self :: Main

	Players.PlayerAdded:Connect(function(player)
		self.BindableComponent:Fire('PlayerAdded', player)
	end)

	print("[PlayerService] initialized")
end

return PlayerService
