--!strict
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local Interfaces = ServerScriptService.GeneratedInterfaces

local DataFabricInterface = require(Interfaces.DataFabricInterface)
local WorldServiceInterface = require(Interfaces.WorldServiceInterface)
local PlayerComponentInterface = require(Interfaces.PlayerComponentInterface)

local PackagesInterfaces = require(ReplicatedStorage.Interfaces.PackagesInterfaces)

local PlayerFabric = {}

PlayerFabric.Scope = "Singleton"
PlayerFabric.Inject = {
	PlayerComponent = "PlayerComponent",
	WorldService = "WorldService",
	DataFabric = "DataFabric",
}

type component = typeof(PackagesInterfaces.Jecs.World.new():component())

export type Main = {
	WorldService: WorldServiceInterface.IWorldService,
	DataFabric: DataFabricInterface.IDataFabric,
	PlayerComponent: PlayerComponentInterface.IPlayerComponent,
} & typeof(PlayerFabric)

local Components = {}

function PlayerFabric.new()
	local self = setmetatable({}, { __index = PlayerFabric })
	return self
end

function PlayerFabric:CreatePlayer(player: Player)
	if Components[player] then warn(`{player} already exists`); return Components[player] end

	self = self :: Main

	local world = self.WorldService.World

	local entity = world:entity()
	--world:set(id, component)
	
	local profile = self.DataFabric:LoadProfile(player.UserId)

	world:set(entity, self.PlayerComponent.ProfileLink, profile)
	world:set(entity, self.PlayerComponent.PlayerInstance, player)

	Components[player] = entity

	return entity
end

function PlayerFabric:GetPlayer(player: Player) 
	return Components[player]
end

return PlayerFabric
