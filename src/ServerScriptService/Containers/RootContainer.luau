--!strict

local EntityContainerModule = require(script.Parent.EntityContainer)
local PlayerContainerModule = require(script.Parent.PlayerContainer)

local Root = {}

function Root.new()
    local EntityContainer = EntityContainerModule.new()
    local PlayerContainer = PlayerContainerModule.new()

    -- пробрасываем тот factory, который нужен playerC (нельзя require PlayerComponent в EntityContainer)
    PlayerContainerModule._entity = EntityContainer.EntityComponent

    return {
        Player = PlayerContainer,
        Entity = EntityContainer,
    }
end

return Root
