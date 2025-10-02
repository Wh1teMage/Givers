--!strict

local ServerScriptService = game:GetService('ServerScriptService')
local ReplicatedStorage = game:GetService('ReplicatedStorage')
local Players = game:GetService('Players')

local Components = ServerScriptService:WaitForChild('Components')
local ServiceContainer = require(Components:WaitForChild('ServiceContainer'))

local PlayerComponent = {}

local Components = {}

function PlayerComponent.new(player: Player)
    local self = setmetatable({
        Instance = player
    }, {__index = PlayerComponent})

    self:Init()

    Components[player.UserId] = self
    return self
end

function PlayerComponent:Init()
    self = self :: typeof(self)


end

function PlayerComponent:Destroy()
    self = self :: typeof(self)

    Components[self.Instance.UserId] = nil

    -- add destruction logic here if needed
    setmetatable(self, nil)
end

local PlayerFabric = {}

function PlayerFabric:CreatePlayerFromInstance(player: Player)
    return PlayerComponent.new(player)
end

function PlayerFabric:CreatePlayerFromId(userId: number)
    local player = Players:GetPlayerByUserId(userId)
    return PlayerComponent.new(player)
end

function PlayerFabric:GetPlayerByInstance(player: Player)
    local component = Components[player.UserId]
    assert(component, 'component doesnt exist')

    return component
end

function PlayerFabric:RemovePlayerByInstance(player: Player)
    local component = PlayerFabric:GetPlayerByInstance(player)
    component:Destroy()
end

local t = 4


return PlayerFabric