--!strict
local RegistryHelperInterface = require(game.ServerScriptService.GeneratedInterfaces.RegistryHelperInterface)
local ComponentInterfaces = require(game.ServerScriptService.GeneratedInterfaces.ComponentInterfaces)

local JecsInterfaces = require(game.ReplicatedStorage.Interfaces.JecsInterfaces)

local BehaviorRegistry = {}
BehaviorRegistry.__index = BehaviorRegistry

BehaviorRegistry.Scope = "Singleton"
BehaviorRegistry.Inject = {
    'RegistryHelper'
}

--great language moment
local Components: ComponentInterfaces.Components;
export type Main = typeof(BehaviorRegistry) & RegistryHelperInterface.IRegistryHelper<
(typeof(Components.Ability.Data.__T.behaviors['test'].args), JecsInterfaces.Entity) -> ...any
>

type Dependencies = {
    RegistryHelper: RegistryHelperInterface.IRegistryHelper<any>
}

type self = Dependencies & Main

function BehaviorRegistry.new()
	local self = setmetatable({}, BehaviorRegistry)
	return self
end

function BehaviorRegistry:Init()
	self = self :: self
    setmetatable(self, {__index = setmetatable(self.RegistryHelper, BehaviorRegistry)})

    -- add LoadFromFolder here
end

return BehaviorRegistry
