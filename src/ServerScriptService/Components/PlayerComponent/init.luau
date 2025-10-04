--!strict
local PlayerComponent = {}

function PlayerComponent.new(_:any)
    local self = setmetatable({}, {__index = PlayerComponent})

    return self
end

function PlayerComponent:Init()
    print('Player Created', self)

    self.DataComponent:Test()
end

function PlayerComponent:Destroy()
    self = self :: typeof(self)

    -- add destruction logic here if needed
    setmetatable(self, nil)
end

return PlayerComponent