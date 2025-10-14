local JecsInterfaces = require(game.ReplicatedStorage.Interfaces.JecsInterfaces)

type Main = {
    id: string,
    cooldown: number,
}

export type Ability = JecsInterfaces.Entity<Main>

return {}