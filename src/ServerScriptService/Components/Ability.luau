local JecsInterfaces = require(game.ReplicatedStorage.Interfaces.JecsInterfaces)

type AbilityData = {
    name: string,
    tags: {string},
    behaviors: {[string]: {trigger: string, args: {[string]: any}}},
    validations: {[string]: {trigger: string, args: {[string]: any}}},
}

type AbilityStatus = {
    scope: string,
    entity: JecsInterfaces.Entity<>
}

export type Data = JecsInterfaces.Entity<AbilityData>
export type StatusData = JecsInterfaces.Entity<AbilityStatus>
export type HasAbility = JecsInterfaces.Entity<>

return {'Data', 'HasAbility', 'StatusData'}