--!strict
local JecsInterfaces = require(game.ReplicatedStorage.Interfaces.JecsInterfaces)

local WorldServiceInterface = require(game.ServerScriptService.GeneratedInterfaces.WorldServiceInterface)


type Dependencies = {
    WorldService: WorldServiceInterface.IWorldService,
}

type Arguments = {
    ['test']: string,
}

local behavior = {
    Inject = { 'WorldService' },
    Factory = function(deps: Dependencies)
        return function(args: Arguments, entity: JecsInterfaces.Entity)
            local world = deps.WorldService.World

            print(args.test)
        end
    end,
}

return behavior