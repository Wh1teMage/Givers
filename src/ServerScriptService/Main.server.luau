--!strict

local ServerScriptService = game:GetService('ServerScriptService')
local IoCManager = ServerScriptService:WaitForChild('IoCManager')

local Registry = require(IoCManager:WaitForChild('Registry'))

local Container = Registry.Build()

local PlayerService = Container.get((Container :: any), 'PlayerService')

print(PlayerService)

PlayerService:Init()