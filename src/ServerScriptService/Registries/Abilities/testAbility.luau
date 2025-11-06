local ComponentInterfaces = require(game.ServerScriptService.GeneratedInterfaces.ComponentInterfaces)

local Components: ComponentInterfaces.Components
type AbilityData = typeof(Components.Ability.Data.__T)

local ability: AbilityData = {
    name = 'test',
    tags = {},
    behaviors = {
        ['testBehavior'] = { args = {['test'] = 'test'}, trigger = 'OnStart' },
        ['projectile'] = { args = {['test'] = 'test'}, trigger = 'OnStart' },
        ['testBehavior2'] = { args = {['changeTo'] = 'OnExplosion', ['delay'] = 1.5}, trigger = 'OnStart' },
    },
    validations = {},
}

--[[

fireball

behaviors:
charge -> wait for ButtonUp -> spawn projectile
projectile -> trigger OnHit
explosion -> whenever OnHit triggeres -> make an explosion -> trigger other event
dealdamage -> whenever explosion event triggers -> deal damage

effects:
charge -> ends whenever projectile is spawned
projectile -> ends whenever OnHit is triggered
explosion -> starts whenever explosion OhHit is triggered

]]

return ability