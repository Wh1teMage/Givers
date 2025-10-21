local ComponentInterfaces = require(game.ServerScriptService.GeneratedInterfaces.ComponentInterfaces)

local Components: ComponentInterfaces.Components
type AbilityData = typeof(Components.Ability.Data.__T)

local ability: AbilityData = {
    name = 'test',
    tags = {},
    behaviors = {
        ['testBehavior'] = { args = {['test'] = 'test'}, trigger = 'OnStart' },
        ['testBehavior2'] = { args = {['changeTo'] = 'OnExplosion', ['delay'] = 1.5}, trigger = 'OnStart' }
    },
    validations = {},
}
