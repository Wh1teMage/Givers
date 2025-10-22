--!strict
local JecsInterfaces = require(game.ReplicatedStorage.Interfaces.JecsInterfaces)

type Dependecnies = {}
type Arguments = {}

local behavior = {
    Inject = { 'WorldService' },
    Factory = function(deps: Dependecnies)
        return function(args: Arguments, entity: JecsInterfaces.Entity)
            print(args)
        end
    end,
}

return behavior