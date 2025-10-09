--!strict
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local Interfaces = ServerScriptService.GeneratedInterfaces

local PackagesInterfaces = require(ReplicatedStorage.Interfaces.PackagesInterfaces)
local profilestore = require(ServerScriptService.ServerPackages.profilestore)

local ContainerInterface = require(Interfaces:WaitForChild("ContainerInterface"))
local WorldServiceInterface = require(Interfaces:WaitForChild("WorldServiceInterface"))

--Templates
local ProfileTemplate = require(ReplicatedStorage.Templates:WaitForChild("DataProfile"))

local DataFabric = {}

local DATA_SCOPE = 'Main'

DataFabric.Scope = "Singleton"
DataFabric.Inject = {
	Container = "Container",
	WorldService = "WorldService",
	Jecs = "Jecs",
	
	profilestore = "ProfileStore",
}

export type Main = {
	WorldService: WorldServiceInterface.IWorldService,
	Jecs: typeof(PackagesInterfaces.Jecs),
	Container: ContainerInterface.IContainer,
	profilestore: typeof(profilestore),
} & typeof(DataFabric) & {
	Data: typeof(PackagesInterfaces.Jecs.World.new():component()),
	ProfileScope: typeof(profilestore.New(DATA_SCOPE, ProfileTemplate())),
}

function DataFabric.new()
	local self = setmetatable({}, { __index = DataFabric })
	return self
end

function DataFabric:Init()
	self = self :: Main
	local world = self.WorldService.World

	self.Data = world:component()

	local ScopedProfile = self.profilestore.New(DATA_SCOPE, ProfileTemplate())
	self.ProfileScope = ScopedProfile
end

function DataFabric:LoadProfile(id: number)
	self = self :: Main
	local world = self.WorldService.World
	local entity = world:entity()

	local Profile = self.ProfileScope:StartSessionAsync(tostring(id), {})

	if Profile ~= nil then
		Profile:AddUserId(id)
		Profile:Reconcile()
	end

	world:set(entity, self.Data, {
		Profile,
	})

	print(Profile)
end

return DataFabric
