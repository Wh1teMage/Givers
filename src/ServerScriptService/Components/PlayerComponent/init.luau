--!strict

local ServerScriptService = game:GetService('ServerScriptService')
local Players = game:GetService('Players')

local Components = ServerScriptService:WaitForChild('Components')

local PlayerComponent = {}

function PlayerComponent.new(dependencies: {}, player: Player)
    local self = setmetatable(dependencies, {__index = PlayerComponent})

    return self
end

function PlayerComponent:Destroy()
    self = self :: typeof(self)

    Components[self.Instance.UserId] = nil

    -- add destruction logic here if needed
    setmetatable(self, nil)
end

return PlayerComponent