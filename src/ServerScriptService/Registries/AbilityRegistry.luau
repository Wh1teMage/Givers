--!strict
local RegistryHelperInterface = require(game.ServerScriptService.GeneratedInterfaces.RegistryHelperInterface)
local ComponentInterfaces = require(game.ServerScriptService.GeneratedInterfaces.ComponentInterfaces)

local JecsInterfaces = require(game.ReplicatedStorage.Interfaces.JecsInterfaces)

local AbilityRegistry = {}
AbilityRegistry.__index = AbilityRegistry

AbilityRegistry.Scope = "Singleton"
AbilityRegistry.Inject = {
    'RegistryHelper'
}

--great language moment
local Components: ComponentInterfaces.Components;
export type Main = typeof(AbilityRegistry) & RegistryHelperInterface.IRegistryHelper<typeof(Components.Ability.Data.__T)>

type Dependencies = {
    RegistryHelper: RegistryHelperInterface.IRegistryHelper<any>
}

type self = Dependencies & Main

function AbilityRegistry.new()
	local self = setmetatable({}, AbilityRegistry)
	return self
end

function AbilityRegistry:Init()
	self = self :: self
    setmetatable(self, {__index = setmetatable(self.RegistryHelper, AbilityRegistry)})
    --self:LoadFromFolder(script.Ab)
    -- add LoadFromFolder here
end

return AbilityRegistry
