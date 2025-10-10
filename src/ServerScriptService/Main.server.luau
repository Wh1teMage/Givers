--Main.luau
--!strict

local ServerScriptService = game:GetService("ServerScriptService")
local IoCManager = ServerScriptService:WaitForChild("IoCManager")

local Registry = require(IoCManager:WaitForChild("Registry"))

local Container = Registry.Build()

print(Container)

local PlayerService = Container.get(Container :: any, "PlayerService")
local WorldService = Container.get(Container :: any, "WorldService")
local PlayerSystem = Container.get(Container :: any, "PlayerSystem")
local DataFabric = Container.get(Container :: any, "DataFabric")

WorldService:Init()
PlayerSystem:Init()
PlayerService:Init()
DataFabric:Init()

local sorted = Container:resolveInitOrder({
	WorldService = WorldService,
	PlayerSystem = PlayerSystem,
	PlayerService = PlayerService,
	DataFabric = DataFabric
})

print(sorted)