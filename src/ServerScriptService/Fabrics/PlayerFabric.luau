--!strict

local PlayerFabric = {}
PlayerFabric.__index = PlayerFabric

function PlayerFabric.new(dependencies: {})
    return setmetatable({ dependencies = dependencies, instances = {} }, PlayerFabric)
end

function PlayerFabric:CreatePlayer()
    --local pc = self.dependencies.PlayerComponent(player)
    --self.instances[player.UserId] = pc
    --return pc

    return 1
end

return PlayerFabric