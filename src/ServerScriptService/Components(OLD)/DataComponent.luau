--!strict
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local Interfaces = ServerScriptService.GeneratedInterfaces
local Templates = ReplicatedStorage:WaitForChild("Templates")

local JecsInterfaces = require(ReplicatedStorage.Interfaces.JecsInterfaces)
local WorldServiceInterface = require(Interfaces:WaitForChild("WorldServiceInterface"))

local ProfileData = require(Templates:WaitForChild("DataProfile"))()

type DataType = typeof(ProfileData)
type ValuesType = typeof(ProfileData.Values)
type InventoryType = typeof(ProfileData.Inventory)
type MultipliersType = typeof(ProfileData.Multipliers)

local DataComponent = {}

DataComponent.Scope = "Singleton"
DataComponent.Inject = {
	WorldService = "WorldService",
}

export type Main = {
	WorldService: WorldServiceInterface.IWorldService,
} & typeof(DataComponent) & {
	Data: JecsInterfaces.Entity<DataType>,
	Values: JecsInterfaces.Entity<ValuesType>,
	Multipliers: JecsInterfaces.Entity<MultipliersType>,
	Inventory: JecsInterfaces.Entity<InventoryType>,
}

function DataComponent.new()
	local self = setmetatable({}, { __index = DataComponent })
	return self
end

function DataComponent:Init()
	self = self :: Main
	local world = self.WorldService.World

	self.Data = world:component() :: JecsInterfaces.Entity<DataType>
	self.Values = world:component() :: JecsInterfaces.Entity<ValuesType>
	self.Inventory = world:component() :: JecsInterfaces.Entity<InventoryType>
	self.Multipliers = world:component() :: JecsInterfaces.Entity<MultipliersType>
end

return DataComponent
