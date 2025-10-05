-- Registry.luau
--!strict

local ReplicatedStorage = game:GetService('ReplicatedStorage')
local IoCManager = ReplicatedStorage:WaitForChild('IoCManager')

local Registry = require(IoCManager.Registry)
local Assemblies = script.Parent.Assemblies

local function buildContainer()
    local container = Registry.Build()

    for _, assembly in pairs(Assemblies:GetChildren()) do
        for name, value in pairs(require(assembly) :: {[string]: any}) do
            container.register((container :: any), name, value)
        end
    end

    return container
end

return {
    Build = buildContainer
}
