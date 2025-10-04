local ServerScriptService = game:GetService('ServerScriptService')
local ReplicatedStorage = game:GetService('ReplicatedStorage')
local Players = game:GetService('Players')

local Components = ServerScriptService:WaitForChild('Components')
local Fabrics = ServerScriptService:WaitForChild('Fabrics')
local IoCManager = ServerScriptService:WaitForChild('IoCManager')

local Containers = ServerScriptService:WaitForChild('Containers')

local Registry = require(IoCManager:WaitForChild('Registry'))

local Container = Registry.Build()
local PlayerFabric = Container:get('PlayerFabric')

print('PlayerFabric', PlayerFabric)

Players.PlayerAdded:Connect(function(player)
    PlayerFabric:CreatePlayer(player)
end)