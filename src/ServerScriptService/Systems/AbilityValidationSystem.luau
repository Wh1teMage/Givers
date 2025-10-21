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

export type Main = typeof(AbilityValidationSystem)

type Dependencies = {
	BindableComponent: BindableInterfaces.IBindableComponent,
	ComponentFabric: ComponentFabricInterface.IComponentFabric,
    WorldService: WorldServiceInterface.IWorldService,
}

type self = Dependencies & Main

function AbilityValidationSystem.new()
	local self = setmetatable({}, AbilityValidationSystem)
	return self
end

function AbilityValidationSystem:Init()
	self = self :: self
    local world = self.WorldService.World
	--[[
	self.BindableComponent:Connect("Ability.CreateRequest", function(payload: {Entity: JecsInterfaces.Entity})
		local requestData = world:get(payload.Entity, self.ComponentFabric.Components.Ability.Request)
		assert(requestData, 'request data doesnt exist!')

		world:remove(payload.Entity, self.ComponentFabric.Components.Ability.Request)

		-- make abilityfabric createability here

		world:add(payload.Entity, self.ComponentFabric.Components.Ability.RequestValid)

        --self.BindableComponent:Fire("Ability.Create", payload) -- trasnferring params

        --instead of this do query
	end)]]
end

return AbilityValidationSystem
