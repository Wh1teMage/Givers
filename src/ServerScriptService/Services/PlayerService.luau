-- PlayerService.luau
--!strict
local Players = game:GetService("Players")

local PlayerService = {}
PlayerService.__index = PlayerService

PlayerService.Scope = "Singleton"
PlayerService.Inject = {
	Container = "Container"
}

function PlayerService.new()
	local self = setmetatable({}, PlayerService)
	return self
end

function PlayerService:Init()
	local PlayerFabric = self.Container:get("PlayerFabric")

	Players.PlayerAdded:Connect(function(player)
		PlayerFabric:CreatePlayer(player)
	end)

	print("[PlayerService] initialized")
end

return PlayerService
