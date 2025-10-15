--!strict
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local Interfaces = ServerScriptService.GeneratedInterfaces

local DataFabricInterface = require(Interfaces.DataFabricInterface)
local WorldServiceInterface = require(Interfaces.WorldServiceInterface)
local PlayerComponentInterface = require(Interfaces.PlayerComponentInterface)
local ComponentFabricInterface = require(Interfaces.ComponentFabricInterface)

local PackagesInterfaces = require(ReplicatedStorage.Interfaces.PackagesInterfaces)
local JecsInterfaces = require(ReplicatedStorage.Interfaces.JecsInterfaces)

local PlayerFabric = {}

PlayerFabric.Scope = "Singleton"
PlayerFabric.Inject = {
	ComponentFabric = "ComponentFabric",
	WorldService = "WorldService",
	DataFabric = "DataFabric",
	Jecs = "Jecs",
}

type component = typeof(PackagesInterfaces.Jecs.World.new():component())

export type Main = {
	Jecs: typeof(PackagesInterfaces.Jecs),
	DataFabric: DataFabricInterface.IDataFabric,
	WorldService: WorldServiceInterface.IWorldService,
	ComponentFabric: ComponentFabricInterface.IComponentFabric,
} & typeof(PlayerFabric)

local Components = {}

function PlayerFabric.new()
	local self = setmetatable({}, { __index = PlayerFabric })
	return self
end

function PlayerFabric:CreatePlayer(player: Player)
	if Components[player] then 
		warn(`{player} already exists`); 
		return Components[player] 
	end

	self = self :: Main

	local world = self.WorldService.World

	local entity = world:entity()
	
	local profile = self.DataFabric:LoadProfile(player.UserId)

	world:set(entity, self.Jecs.pair(self.ComponentFabric.Components.Data.ProfileLink, profile))
	world:set(entity, self.ComponentFabric.Components.Player.PlayerInstance, player)

	Components[player] = entity

	return entity
end

function PlayerFabric:GetPlayer(player: Player) 
	return Components[player]
end

return PlayerFabric
