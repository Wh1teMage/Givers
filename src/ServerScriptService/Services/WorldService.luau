--!strict
local ServerScriptService = game:GetService('ServerScriptService')
local Interfaces = ServerScriptService.Interfaces

local WorldServiceInterface = require(Interfaces.WorldServiceInterface)

local WorldService = {}
WorldService.__index = WorldService

WorldService.Scope = "Singleton"
WorldService.Inject = {
	Container = "Container",
    Jecs = "Jecs"
}

function WorldService.new()
	local self = setmetatable({}, WorldService)
	return self
end

function WorldService:Init()
    self = self :: WorldServiceInterface.IWorldService

    self.World = self.Jecs.World.new()
end
--

return WorldService