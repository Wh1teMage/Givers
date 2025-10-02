--!strict

local ServerScriptService = game:GetService('ServerScriptService')
local ReplicatedStorage = game:GetService('ReplicatedStorage')
local Players = game:GetService('Players')

local Components = ServerScriptService:WaitForChild('Components')
local PlayerFabric = require(Components:WaitForChild('PlayerComponent'))

Players.PlayerAdded:Connect(function(player)
    PlayerFabric:CreatePlayerFromInstance(player)
end)

local Contaier = require(Components:WaitForChild('Container'))

for _,v in pairs(Containers:GetChildren()) do
    if v:IsA('ModuleScript') then
        require(v)
    end
end

local test = {}
test["1"] = false

local charm = Contaier:get('TestService')
print(charm)
