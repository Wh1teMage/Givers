--!strict

local ServerScriptService = game:GetService('ServerScriptService')
local ReplicatedStorage = game:GetService('ReplicatedStorage')
local Players = game:GetService('Players')

local Components = ServerScriptService:WaitForChild('Components')
local PlayerFabric = require(Components:WaitForChild('PlayerComponent'))

Players.PlayerAdded:Connect(function(player)
    PlayerFabric:CreatePlayerFromInstance(player)
end)

Players.PlayerRemoving:Connect(function(player)
    PlayerFabric:RemovePlayerByInstance(player)
end)