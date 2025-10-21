--!strict

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")

local Interfaces = ReplicatedStorage:WaitForChild("Interfaces")

local BindableInterfaces = require(game.ServerScriptService.GeneratedInterfaces.BindableComponentInterface)
local ComponentFabricInterface = require(game.ServerScriptService.GeneratedInterfaces.ComponentFabricInterface)
local WorldServiceInterface = require(game.ServerScriptService.GeneratedInterfaces.WorldServiceInterface)

local JecsInterfaces = require(game.ReplicatedStorage.Interfaces.JecsInterfaces)

local AbilityConfigurationSystem = {}
AbilityConfigurationSystem.__index = AbilityConfigurationSystem

AbilityConfigurationSystem.Scope = "Singleton"
AbilityConfigurationSystem.Inject = {
	BindableComponent = "BindableComponent",
	ComponentFabric = "ComponentFabric",
    WorldService = "WorldService"
}

export type Main = typeof(AbilityConfigurationSystem)

type Dependencies = {
	BindableComponent: BindableInterfaces.IBindableComponent,
	ComponentFabric: ComponentFabricInterface.IComponentFabric,
    WorldService: WorldServiceInterface.IWorldService,
}

type self = Dependencies & Main

function AbilityConfigurationSystem.new()
	local self = setmetatable({}, AbilityConfigurationSystem)
	return self
end

function AbilityConfigurationSystem:Init()
	self = self :: self
    local world = self.WorldService.World

    -- make this one into container or some kind of system register
	
    RunService:BindToRenderStep('AbilityConfiguration', 10, function()
        self:Update()
    end)
end

function AbilityConfigurationSystem:Update()
	self = self :: self
    local world = self.WorldService.World

    --local data = world:get(world:entity(), self.ComponentFabric.Components.Ability.Data)

    --[[
    for entity in world:query(self.ComponentFabric.Components.Ability.RequestValid) do
        world:remove(entity, self.ComponentFabric.Components.Ability.RequestValid)
        world:add(entity, self.ComponentFabric.Components.Ability.CreationInProcess)

        local abilityData = world:get(entity, self.ComponentFabric.Components.Ability.Data)
        
        --add some kind of behaviour register here.

        --[[
        
        ContextAction -> Remote -> ? -> Bindable -> Create Request -> ValidationSystem Registers this request ->
        -> Creates RequestValid -> ConfigurationSystem -> Creates InProcess -> Gets Ability Data -> 
        -> Starts configuring behaviours based on data

        how to connect ability request
        how and when to link ability and ability owner
        how to handle states like reqValid, creationInProcess correctly (flags/enums/etc)
        how to process behaviours

        
    end
    ]]
end

return AbilityConfigurationSystem
