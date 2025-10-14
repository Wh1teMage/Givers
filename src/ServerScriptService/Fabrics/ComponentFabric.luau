--!strict
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local Interfaces = ServerScriptService.GeneratedInterfaces
local Components = ServerScriptService.ComponentsTest

local PackagesInterfaces = require(ReplicatedStorage.Interfaces.PackagesInterfaces)
local profilestore = require(ServerScriptService.ServerPackages.profilestore)

local WorldServiceInterface = require(Interfaces:WaitForChild("WorldServiceInterface"))
local ComponentInterfaces = require(Interfaces:WaitForChild("ComponentInterfaces"))


local ComponentFabric = {}

ComponentFabric.Scope = "Singleton"
ComponentFabric.Inject = {
    WorldService = "WorldService",
	Jecs = "Jecs",
}

export type Main = {
    WorldService: WorldServiceInterface.IWorldService,
	Jecs: typeof(PackagesInterfaces.Jecs),
} & typeof(ComponentFabric) & {
    Components: ComponentInterfaces.Components
}

function ComponentFabric.new()
	local self = setmetatable({}, { __index = ComponentFabric })
	return self
end

function ComponentFabric:Init()
	self = self :: Main
    if (self.Components) then 
        warn('already hydrated'); 
        return 
    end

    self.Components = {} :: ComponentInterfaces.Components
    assert(self.Components)

    local world = self.WorldService.World

    for _, module in ipairs(Components:GetChildren()) do
        local data = require(module) :: {string}
        local scope = {}

        for _, dataType in ipairs(data) do
            scope[dataType] = world:component()
        end

        self.Components[module.Name] = scope :: any
    end
end

return ComponentFabric
