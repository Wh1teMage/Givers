--Main.luau
--!strict

local ServerScriptService = game:GetService('ServerScriptService')
local IoCManager = ServerScriptService:WaitForChild('IoCManager')

local Registry = require(IoCManager:WaitForChild('Registry'))

local Container = Registry.Build()

local PlayerService = Container.get((Container :: any), 'PlayerService')
local WorldService = Container.get((Container :: any), 'WorldService')
local PlayerSystem = Container.get((Container :: any), 'PlayerSystem')

print(PlayerService)

WorldService:Init()
PlayerSystem:Init()
PlayerService:Init()