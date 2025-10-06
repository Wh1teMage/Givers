local PlayerFabric = {}
PlayerFabric.__index = PlayerFabric

PlayerFabric.Scope = 'Singleton'

PlayerFabric.Inject = {
    Container = 'Container',
}

local Components = {}

function PlayerFabric.new(_: any)
    local self = setmetatable({}, PlayerFabric)

    print('created', self)

    return self
end

function PlayerFabric:CreatePlayer(player: Player)
    if Components[player] then return end

    local container = self.Container

    local component = container:createWithArgs('PlayerComponent', { Instance = player })
    local dataComponent = container:createWithArgs('DataComponent', { Player = component })

    component.DataComponent = dataComponent

    component:Init()

    return component
end

return PlayerFabric