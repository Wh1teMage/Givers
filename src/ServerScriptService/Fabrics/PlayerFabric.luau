--!strict
local ServerScriptService = game:GetService('ServerScriptService')
local Interfaces = ServerScriptService.GeneratedInterfaces

local ContainerInterface = require(Interfaces.ContainerInterface)
local WorldServiceInterface = require(Interfaces.WorldServiceInterface)

local PlayerFabric = {}

PlayerFabric.Scope = 'Singleton'
PlayerFabric.Inject = {
    Container = 'Container',
    WorldService = 'WorldService',
}

export type Main = { 
    WorldService: WorldServiceInterface.IWorldService,
    Container: ContainerInterface.IContainer,
} & typeof(PlayerFabric)

local Components = {}

function PlayerFabric.new()
    local self = setmetatable({}, {__index = PlayerFabric})

    print('created', self)

    return self
end

function PlayerFabric:CreatePlayer(player: Player)
    if Components[player] then return end

    self = self :: Main

    local world = self.WorldService.World

    local entity = world:entity()
    --world:set(id, component)

    return entity
end

function PlayerFabric:GetPlayer()

end

return PlayerFabric