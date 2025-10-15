local JecsInterfaces = require(game.ReplicatedStorage.Interfaces.JecsInterfaces)

type AbilityData = {
    id: string,
    cooldown: number,
}

type RequestData = {
    id: string
}

export type Data = JecsInterfaces.Entity<AbilityData>
export type Request = JecsInterfaces.Entity<RequestData>
export type OwnsAbility = JecsInterfaces.Entity<>

export type RequestValid = JecsInterfaces.Entity<>
export type CreationInProcess = JecsInterfaces.Entity<>

return {'Data', 'OwnsAbility', 'Request', 'RequestValid', 'CreationInProcess'}