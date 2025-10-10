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
	ProfileLink: (JecsInterfaces.Entity<JecsInterfaces.Entity<any>> & number),
	PlayerInstance: (JecsInterfaces.Entity<Player> & number),
}

function DataComponent.new()
	local self = setmetatable({}, { __index = DataComponent })
	return self
end

function DataComponent:Init()
    self = self :: Main
	local world = self.WorldService.World

    self.ProfileLink = world:component() :: (JecsInterfaces.Entity<number> & number)
	self.PlayerInstance = world:component() :: (JecsInterfaces.Entity<number> & number)
end

return DataComponent