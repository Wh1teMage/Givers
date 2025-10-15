--!strict

local ServerScriptService = game:GetService('ServerScriptService')
local ReplicatedStorage = game:GetService('ReplicatedStorage')
local Players = game:GetService('Players')

local Components = ServerScriptService:WaitForChild('Components')
local ServiceContainer = require(Components:WaitForChild('ServiceContainer'))

local Sift = ServiceContainer['Sift']()



local EntityComponent = {}

local Methods = {}

function EntityComponent:RegisterId()

    

end   

function EntityComponent.new()

    local self = setmetatable(Sift.Dictionary.copyDeep({})
, 
    {
        __index = function(t,key)
            return Methods[key]
        end
    })


    return self
end




return EntityComponent