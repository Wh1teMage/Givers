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

local PlayerComponent = Container.get(Container :: any, "PlayerComponent")
local DataComponent = Container.get(Container :: any, "DataComponent")
local CoinSystem = Container.get(Container :: any, "CoinSystem")

WorldService:Init()

PlayerComponent:Init()
DataComponent:Init()

PlayerService:Init()
DataFabric:Init()

PlayerSystem:Init()
CoinSystem:Init()

