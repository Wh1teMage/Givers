--!strict
local ServerScriptService = game:GetService('ServerScriptService')
local Interfaces = ServerScriptService.Interfaces

local WorldServiceInterface = require(Interfaces.WorldServiceInterface)

local PlayerFabric = {}
PlayerFabric.__index = PlayerFabric

PlayerFabric.Scope = 'Singleton'

PlayerFabric.Inject = {
    Container = 'Container',
    WorldService = 'WorldService',
}

local Components = {}

function PlayerFabric.new(_: any)
    local self = setmetatable({}, PlayerFabric)

    print('created', self)

    return self
end

function PlayerFabric:CreatePlayer(player: Player)
    if Components[player] then return end

    self.WorldService = self.WorldService :: WorldServiceInterface.IWorldService

    local world = self.WorldService.World

    local entity = world:entity()
    --world:set(id, component)


    return entity
end

return PlayerFabric