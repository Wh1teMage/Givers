--!strict
local RegistryHelperInterface = require(game.ServerScriptService.GeneratedInterfaces.RegistryHelperInterface)
local ComponentInterfaces = require(game.ServerScriptService.GeneratedInterfaces.ComponentInterfaces)

local JecsInterfaces = require(game.ReplicatedStorage.Interfaces.JecsInterfaces)

local ValidationRegistry = {}
ValidationRegistry.__index = ValidationRegistry

ValidationRegistry.Scope = "Singleton"
ValidationRegistry.Inject = {
    'RegistryHelper'
}

--great language moment
local Components: ComponentInterfaces.Components;
export type Main = typeof(ValidationRegistry) & RegistryHelperInterface.IRegistryHelper<
(typeof(Components.Ability.Data.__T.validations['test'].args), JecsInterfaces.Entity) -> boolean
>

type Dependencies = {
    RegistryHelper: RegistryHelperInterface.IRegistryHelper<any>
}

type self = Dependencies & Main

function ValidationRegistry.new()
	local self = setmetatable({}, ValidationRegistry)
	return self
end

function ValidationRegistry:Init()
	self = self :: self
    setmetatable(self, {__index = setmetatable(self.RegistryHelper, ValidationRegistry)})

    -- add LoadFromFolder here
end


return ValidationRegistry
