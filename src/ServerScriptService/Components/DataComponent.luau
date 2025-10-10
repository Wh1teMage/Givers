--!strict
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local Interfaces = ServerScriptService.GeneratedInterfaces

local JecsInterfaces = require(ReplicatedStorage.Interfaces.JecsInterfaces)
local WorldServiceInterface = require(Interfaces:WaitForChild("WorldServiceInterface"))

local DataComponent = {}

DataComponent.Scope = "Singleton"
DataComponent.Inject = {
	WorldService = "WorldService",
}

export type Main = {
	WorldService: WorldServiceInterface.IWorldService,
} & typeof(DataComponent) & {
	Data: JecsInterfaces.Entity<any>,
	Value: JecsInterfaces.Entity<any>,
	Multiplier: JecsInterfaces.Entity<any>, 
	Inventory: JecsInterfaces.Entity<any>,
}

function DataComponent.new()
	local self = setmetatable({}, { __index = DataComponent })
	return self
end

function DataComponent:Init()
    self = self :: Main
	local world = self.WorldService.World

    self.Data = world:component() :: JecsInterfaces.Entity<number>
	self.Value = world:component() :: JecsInterfaces.Entity<number>
	self.Inventory = world:component() :: JecsInterfaces.Entity<number>
	self.Multiplier = world:component() :: JecsInterfaces.Entity<number>
end

return DataComponent