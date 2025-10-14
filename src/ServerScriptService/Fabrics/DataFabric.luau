--!strict
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local Interfaces = ServerScriptService.GeneratedInterfaces

local PackagesInterfaces = require(ReplicatedStorage.Interfaces.PackagesInterfaces)
local profilestore = require(ServerScriptService.ServerPackages.profilestore)

local DataComponentInterface = require(Interfaces:WaitForChild("DataComponentInterface"))
local WorldServiceInterface = require(Interfaces:WaitForChild("WorldServiceInterface"))

--Templates
local ProfileTemplate = require(ReplicatedStorage.Templates:WaitForChild("DataProfile"))

local DataFabric = {}

local DATA_SCOPE = "Main"

DataFabric.Scope = "Singleton"
DataFabric.Inject = {
	DataComponent = "DataComponent",
	WorldService = "WorldService",
	profilestore = "ProfileStore",
	Jecs = "Jecs",
}

local function test(world)
	return {
		Passive = world:component("Passive"),
		Health = world:component("Health"),
		Mana = world:component("Mana"),
		AbilityRequest = world:component("AbilityRequest"),
		Cooldown = world:component("Cooldown"),
	}
end


export type Main = {
	DataComponent: DataComponentInterface.IDataComponent,
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

	world:set(entity, self.DataComponent.Data, profile.Data)

	world:set(entity, self.DataComponent.Values, profile.Data.Values)
	world:set(entity, self.DataComponent.Inventory, profile.Data.Inventory)
	world:set(entity, self.DataComponent.Multipliers, profile.Data.Multipliers)

	print(`{id} profile was loaded {profile}`)

	return entity
end

return DataFabric
