--!strict
local ServerScriptService = game:GetService("ServerScriptService")
local Interfaces = ServerScriptService.GeneratedInterfaces

local ContainerInterface = require(Interfaces.ContainerInterface)
local DataFabricInterface = require(Interfaces.DataFabricInterface)
local WorldServiceInterface = require(Interfaces.WorldServiceInterface)

local PlayerFabric = {}

PlayerFabric.Scope = "Singleton"
PlayerFabric.Inject = {
	Container = "Container",
	WorldService = "WorldService",
	DataFabric = "DataFabric",
}

export type Main = {
	WorldService: WorldServiceInterface.IWorldService,
	Container: ContainerInterface.IContainer,
	DataFabric: DataFabricInterface.IDataFabric,
} & typeof(PlayerFabric)

local Components = {}

function PlayerFabric.new()
	local self = setmetatable({}, { __index = PlayerFabric })

	print("created", self)

	return self
end

function PlayerFabric:CreatePlayer(player: Player)
	if Components[player] then
		return
	end

	self = self :: Main

	local world = self.WorldService.World

	local entity = world:entity()
	--world:set(id, component)

	self.DataFabric:LoadProfile(player.UserId)

	return entity
end

function PlayerFabric:GetPlayer() end

return PlayerFabric
