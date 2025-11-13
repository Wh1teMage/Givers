local task = require('@lune/task')


local Ability = {}
local Parser = {}
Parser.__index = Parser


function Ability.create(data)
    local parser = Parser.new(data)


    --parser:Parse(data)


    return parser
end


setmetatable(Ability, {
    __call = function(t, i)
        return t[i]
    end
})


local behaviors = {
    ['SpawnLinearProjectile'] = function(parser, path)
        print('spawned')
        --print(parser.Events)
        task.delay(2, function()
            parser:TriggerEvent(path..'.Event.OnHit', {
                Test = 'Test2'
            })
        end)
        --print(path..'.Event.OnHit')
    end,


    ['Damage'] = function()
        print('Damage')
    end,


    ['VFX'] = function(parser, path, config, data)
        print('VFX', config.Test, data.Test)
    end,


    ['VFX2'] = function(parser, path, config, data)
        print('VFX', config.Test, data.Test)
    end
}


local scopeBehaviors = {
    ['Event'] = function(parser, action, path)
        parser.Events[path] = action
    end,


    ['Action'] = function(parser, action, path, data, name)
        parser.Actions[path] = action
        parser:Execute(name, path, action.Config, data)
        parser:Parse(action, path, data)
    end
}


function Parser.new(object)
    local self = setmetatable({
        Events = {},
        Actions = {},
        Object = object,
    }, Parser)


    return self
end


function Parser:Execute(name, path, config, data)
    if (not behaviors[name]) then return end 
    behaviors[name](self, path, config, data)
end


function Parser:Parse(actions, path, data)
    if (not path) then path = '' end


    for key, value in pairs(actions) do
        local scopes = string.split(key, '.')
        if (#scopes < 2) then continue end


        local scope = scopes[1]
        local name = scopes[2]


        if (not scopeBehaviors[scope]) then continue end


        local newPath = path..'.'..key


        scopeBehaviors[scope](self, value, newPath, data, name)
    end
end


function Parser:TriggerEvent(path, args)
    if (not self.Events[path]) then return end
    local eventBlock = self.Events[path]


    self:Parse(eventBlock, path, args)
end


function Parser:ReplaceBlock(path, newBlock, name)
    local values = string.split(path, '.')
    local pathBlocks = {}
    local parentBlock = self.Object


    for i = 1, #values, 2 do
        table.insert(pathBlocks, values[i]..'.'..values[i+1])
    end
    
    for index, block in pairs(pathBlocks) do
        if (index == #pathBlocks) then
            parentBlock[block] = nil -- table clear
            parentBlock[name] = newBlock
        end


        parentBlock = parentBlock[block]
    end
    
    --self.Object[path] = newBlock
end


local ability = Ability 'create' {
    Config = {
        name = 'Test'
    },


    ['Event.OnStart'] = {


        ['Action.SpawnLinearProjectile'] = {


            ['Event.OnHit'] = {


                ['Action.Damage'] = {
                    
                },


                ['Action.VFX'] = {
                    Config = {
                        Test = 'test'
                    }
                }


            }


        }


    }
}


ability:ReplaceBlock(
    'Event.OnStart.Action.SpawnLinearProjectile.Event.OnHit.Action.Damage',
    {
        Config = {
            Test = 'hello'
        }
    },
    'Action.VFX2'
)


--print(ability.Object['Event.OnStart']['Action.SpawnLinearProjectile'])


ability:Parse(ability.Object)


return ability