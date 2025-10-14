local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local Interfaces = ServerScriptService.GeneratedInterfaces
local Templates = ReplicatedStorage:WaitForChild("Templates")

local JecsInterfaces = require(ReplicatedStorage.Interfaces.JecsInterfaces)
local WorldServiceInterface = require(Interfaces:WaitForChild("WorldServiceInterface"))

local PassiveTemplate = require(Templates:WaitForChild("Passive"))()

type DataType = typeof(PassiveTemplate.Data)

local PassiveComponent = {}

PassiveComponent.Scope = "Singleton"
PassiveComponent.Inject = {
	WorldService = "WorldService",
}

export type Main = {
	WorldService: WorldServiceInterface.IWorldService,
} & typeof(PassiveComponent) & {
	Data: JecsInterfaces.Entity<DataType>,
	Passive: JecsInterfaces.Entity<>,
}

function PassiveComponent.new()
	local self = setmetatable({}, { __index = PassiveComponent })
	return self
end

function PassiveComponent:Init()
	self = self :: Main
	local world = self.WorldService.World

	self.Data = world:component()
	self.Passive = world:component()
end

return PassiveComponent
