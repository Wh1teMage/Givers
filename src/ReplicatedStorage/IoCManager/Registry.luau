-- Registry.luau
--!strict

local ContainerModule = require(script.Parent.Container)
local Assemblies = script.Parent.Assemblies

local function buildContainer()
    local registry = {}

    for _, assembly in pairs(Assemblies:GetChildren()) do
        for name, value in pairs(require(assembly) :: {[string]: any}) do
            registry[name] = value
        end
    end

    return ContainerModule.new(registry)
end

return {
    Build = buildContainer
}
