--!strict

local ServerScriptService = game:GetService('ServerScriptService')
local ReplicatedStorage = game:GetService('ReplicatedStorage')
local Players = game:GetService('Players')

local Components = ServerScriptService:WaitForChild('Components')
local Fabrics = ServerScriptService:WaitForChild('Fabrics')

local Containers = ServerScriptService:WaitForChild('Containers')

local PlayerFabric = require(Fabrics:WaitForChild('PlayerFabric'))

local Root = require(Containers.RootContainer).new()

local playerFabric = PlayerFabric.new({ PlayerComponent = Root.Player.PlayerComponent })

local pc = playerFabric:CreatePlayer()
--pc.Data:LoadProfile()
