-- PlayerService.luau
--!strict
local ContainerInterface = require(game.ServerScriptService.GeneratedInterfaces.ContainerInterface)
local WorldServiceInterface = require(game.ServerScriptService.GeneratedInterfaces.WorldServiceInterface)

local Players = game:GetService("Players")

local PlayerService = {}
PlayerService.__index = PlayerService

PlayerService.Scope = "Singleton"
PlayerService.Inject = {
	Container = "Container",
	WorldService = "WorldService"
}

export type Main = { 
	WorldService: WorldServiceInterface.IWorldService,
    Container: ContainerInterface.IContainer,
} & typeof(PlayerService)

function PlayerService.new()
	local self = setmetatable({}, PlayerService)
	return self
end

function PlayerService:Init()
	self = self :: Main

	self.WorldService.EventBus:Wait("PlayerAdded", 60):andThen(function(test)
		print('ello', test)
	end)

	Players.PlayerAdded:Connect(function(player)
		self.WorldService.EventBus:Fire('PlayerAdded', {Player = player})
	end)

	print("[PlayerService] initialized")
end

return PlayerService
