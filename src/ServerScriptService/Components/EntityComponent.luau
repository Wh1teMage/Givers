--!strict

local ServerScriptService = game:GetService('ServerScriptService')
local ReplicatedStorage = game:GetService('ReplicatedStorage')

local ClientComponents = ReplicatedStorage:WaitForChild('Components')
local Components = ServerScriptService:WaitForChild('Components')

local EntityComponent = {}

local Methods = {}

function EntityComponent:RegisterId()

end

function EntityComponent.new(dependencies: {})
    local self = setmetatable({}, 
    {
        __index = function(_,key)
            return Methods[key]
        end
    })

    return self
end




return EntityComponent