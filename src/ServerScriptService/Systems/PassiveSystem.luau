--!strict

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local ServerStorage = game:GetService("ServerStorage")

local Interfaces = ServerScriptService:WaitForChild("GeneratedInterfaces")
local RInterfaces = ReplicatedStorage:WaitForChild("Interfaces")

local BindableInterfaces = require(Interfaces.BindableComponentInterface)
local PassiveInterfaces = require(Interfaces:WaitForChild("PassiveFabricInterface"))
local WorldServiceInterface = require(Interfaces.WorldServiceInterface)

local PassiveSystem = {}
PassiveSystem.__index = PassiveSystem

PassiveSystem.Scope = "Singleton"
PassiveSystem.Inject = {
	WorldService = "WorldService",
	BindableComponent = "BindableComponent",
	PassiveFabric = "PassiveFabric",
}

export type Main = {
	WorldService: WorldServiceInterface.IWorldService,
	BindableComponent: BindableInterfaces.IBindableComponent,
	PassiveFabric: PassiveInterfaces.IPassiveFabric,
} & typeof(PassiveSystem)

function PassiveSystem.new()
	local self = setmetatable({}, PassiveSystem)
	return self
end

function PassiveSystem:Init()
	self = self :: Main

	local PassivesFolder = ServerStorage:FindFirstChild("Passives")

	for _, folder in PassivesFolder:GetChildren() do
		for i, Passive: ModuleScript in folder:GetChildren() do
			local Config = require(Passive:WaitForChild("Config")) :: any
			self.PassiveFabric.CreatePassive(self.PassiveFabric :: any, Config.Type, Config.Name, Config.Level)
		end
	end
end

return PassiveSystem
