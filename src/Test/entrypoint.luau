local test = require('./Packagev2/TreeNode')

local scopeRegistry = test.Registry.new()

scopeRegistry:Register('Action', function(self, node) 
    local behavior = self.BehaviorRegistry:Get(node.Name)
    if (behavior) then behavior(self, node) end
    
    for _, child in node.Children do
        --print(node.Children[child])
        self:Parse(child)
    end
end)

scopeRegistry:Register('Event', function(self, node) 
    --local behavior = self.BehaviorRegistry:Get(node.Name)
    --if (behavior) then behavior(self, node) end

    self.Events[node.Name] = node
end)

scopeRegistry:Register('TriggerEvent', function(self, node)

end)

local behaviorRegistry = test.Registry.new()

behaviorRegistry:Register('Root', function(self, node)  
    --print('root created', self)
end)

behaviorRegistry:Register('Test', function(self, node)  
    --print('root created', self)
end)

behaviorRegistry:Register('Hello', function(self, node)  
    print('hello', node.Config)
end)

behaviorRegistry:Register('Fire', function(self, node)  
    if (not self.Events) then return end
    local handler = self.ScopeRegistry:Get('Action')

    local selectedBlock = self.Events[node.Config.EventName]
    selectedBlock.Config.EventData = node.Config

    for _, child in selectedBlock.Children do
        child.Config.EventData = node.Config
    end

    if handler then handler(self, selectedBlock) end
end)


local parser = test.AbilityParser.new()
parser.BehaviorRegistry = behaviorRegistry
parser.ScopeRegistry = scopeRegistry

local ability = parser:Create({

    ['Event.Test'] = {
        ['Action.Hello'] = {
            Config = {
                test = 1123
            }
        }
    }
})

ability:Build()

ability:Parse(
    {
        Name = 'Fire',
        Type = 'Event',
        Config = {
            EventName = 'Test',
            tst = 1234,
        }
    }
)

local test = {
    Name = 'Event.OnHit',
    id = 123, -- unique key
    Tag = '@main',
    Children = {
        {
            Name = 'Action.Hello',
            RequiredTags = {'@main'},

            Config = {
                test = 123,
            }


        },
        {
            Name = 'Event.OnHit',
            Tag = '@main',
        }
    }
}


--[[
Event.OnHit is registered 2 times
solution: table insert
fireball

table insert makes it so that we cant trigger a specific event 
instead, we trigger all of the event with that specific name
solution: Event.OnHit2

we use a tag system, which leads to blocks
reading parent values not by names but by tags
E.x

behaviorRegistry:Register('Root', function(self, node)  
    self:GetTag('Damage') -> {
        Damage = 10,
        Type = 'test'
    }
end)

{
    Name = 'Event.Root',
    Tag = 'Damage',
}

у нас 2 блока могут быть с одинаковыми тегами
типо Damage

в 1 части кода у нас Damage для fireball
во 2 части кода - для fireballExplosion

пусть у нас Fireball имеет возможность пробивать противников, 
а взырвается только при соприкосновении с terrain

тогда у нас урон и так и так сможет работать 
(т.е OnHit будет триггерится в обоих случаях, но это разные ивенты)

учитывай, что у Explosion тоже есть OnHit

а как ты родителя будешь получать из блока? (по id)
а можешь пример накидать?



]]

--ability:FireEvent('Test', {tst = 123})

--print(ability)

--print(test)