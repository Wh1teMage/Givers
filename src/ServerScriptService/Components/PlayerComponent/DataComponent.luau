local DataComponent = {}
DataComponent.__index = DataComponent

function DataComponent.new(_: any)
    local self = setmetatable({}, DataComponent)
    
    -- Initialize your DataComponent here using dependencies and player

    return self
end

function DataComponent:Test()
    print(self.Player)
end

return DataComponent