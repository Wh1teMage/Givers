--Main.luau
--!strict

local ServerScriptService = game:GetService("ServerScriptService")
local IoCManager = ServerScriptService:WaitForChild("IoCManager")

local Registry = require(IoCManager:WaitForChild("Registry"))

local Container = Registry.Build()

print(Container)



warn('here!!!')
Container.resolveInitOrder(Container :: any)