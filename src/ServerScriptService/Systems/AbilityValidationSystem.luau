--!strict

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Interfaces = ReplicatedStorage:WaitForChild("Interfaces")

local BindableInterfaces = require(game.ServerScriptService.GeneratedInterfaces.BindableComponentInterface)
local ComponentFabricInterface = require(game.ServerScriptService.GeneratedInterfaces.ComponentFabricInterface)
local WorldServiceInterface = require(game.ServerScriptService.GeneratedInterfaces.WorldServiceInterface)

local JecsInterfaces = require(game.ReplicatedStorage.Interfaces.JecsInterfaces)

local AbilityValidationSystem = {}
AbilityValidationSystem.__index = AbilityValidationSystem

AbilityValidationSystem.Scope = "Singleton"
AbilityValidationSystem.Inject = {
	BindableComponent = "BindableComponent",
	ComponentFabric = "ComponentFabric",
    WorldService = "WorldService"
}

export type Main = {
	BindableComponent: BindableInterfaces.IBindableComponent,
	ComponentFabric: ComponentFabricInterface.IComponentFabric,
    WorldService: WorldServiceInterface.IWorldService,
} & typeof(AbilityValidationSystem)

function AbilityValidationSystem.new()
	local self = setmetatable({}, AbilityValidationSystem)
	return self
end

function AbilityValidationSystem:Init()
	self = self :: Main
    local world = self.WorldService.World
	
	self.BindableComponent:Connect("Ability.OnCreateRequest", function(payload: {Entity: JecsInterfaces.Entity})
		local requestData = world:get(payload.Entity, self.ComponentFabric.Components.Ability)
		assert(requestData, 'request data doesnt exist!')

        self.BindableComponent:Fire("Ability.OnCreate", payload) -- trasnferring params

        --instead of this do query
	end)
end

return AbilityValidationSystem
