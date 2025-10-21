--!strict
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local Interfaces = ServerScriptService.GeneratedInterfaces

local PackagesInterfaces = require(ReplicatedStorage.Interfaces.PackagesInterfaces)
local profilestore = require(ServerScriptService.ServerPackages.profilestore)

local WorldServiceInterface = require(Interfaces:WaitForChild("WorldServiceInterface"))
local ComponentFabricInterface = require(Interfaces:WaitForChild("ComponentFabricInterface"))

--Templates
local ProfileTemplate = require(ReplicatedStorage.Templates:WaitForChild("DataProfile"))

local DataFabric = {}

local DATA_SCOPE = "Main"

DataFabric.Scope = "Singleton"
DataFabric.Inject = {
	ComponentFabric = "ComponentFabric",
	WorldService = "WorldService",
	profilestore = "ProfileStore",
	Jecs = "Jecs",
}

export type Main = {
	ComponentFabric: ComponentFabricInterface.IComponentFabric,
	WorldService: WorldServiceInterface.IWorldService,
	Jecs: typeof(PackagesInterfaces.Jecs),
	profilestore: typeof(profilestore),
} & typeof(DataFabric) & {
	ProfileScope: typeof(profilestore.New(DATA_SCOPE, ProfileTemplate())),
}

function DataFabric.new()
	local self = setmetatable({}, { __index = DataFabric })
	return self
end

function DataFabric:Init()
	self = self :: Main

	local ScopedProfile = self.profilestore.New(DATA_SCOPE, ProfileTemplate())
	self.ProfileScope = ScopedProfile
end

function DataFabric:LoadProfile(id: number)
	self = self :: Main
	local world = self.WorldService.World
	local entity = world:entity()

	local profile = self.ProfileScope:StartSessionAsync(tostring(id), {})

	assert(profile, `{id} profile doenst exist`)

	profile:AddUserId(id)
	profile:Reconcile()

	world:set(entity, self.ComponentFabric.Components.Data.Data, profile.Data)

	world:set(entity, self.ComponentFabric.Components.Data.Values, profile.Data.Values)
	world:set(entity, self.ComponentFabric.Components.Data.Inventory, profile.Data.Inventory)
	world:set(entity, self.ComponentFabric.Components.Data.Multipliers, profile.Data.Multipliers)

	print(`{id} profile was loaded {profile}`)

	return entity
end

return DataFabric
