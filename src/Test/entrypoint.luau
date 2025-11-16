local test = require('./Packagev2/TreeNode')

local scopeRegistry = test.Registry.new()

scopeRegistry:Register('Action', function(self, node) 

    for key, tag in pairs(node.RequestedTags or {}) do
        --print(key, tag, self.Tags)
        node.Additional[key] = self.Tags[tag] or {}
    end

    local behavior = self.BehaviorRegistry:Get(node.Name)
    if (behavior) then behavior(self, node) end
    if (node.Tag) then
        self.Tags[node.Tag] = node.Config
    end

    --print(node.Name, self.Tags)

    for _, child in (node.Children or {}) do
        --print(node.Children[child])
        self:Execute(child)
    end
end)

scopeRegistry:Register('Event', function(self, node) 
    --local behavior = self.BehaviorRegistry:Get(node.Name)
    --if (behavior) then behavior(self, node) end
    if (self.Events[node.Tag]) then warn(node.Tag..' already exists!'); return end
    self.Events[node.Tag] = node
end)

local behaviorRegistry = test.Registry.new()

behaviorRegistry:Register('TriggerEvent', function(self, node)  
    if (not self.Events) then return end
    local handler = self.ScopeRegistry:Get('Action')

    local selectedBlock = self.Events[node.Config.TagName]
    selectedBlock.TriggerArgs = node.Config
    
    --selectedBlock.Config = node.Config

    self.Tags[node.Config.TagName] = node.Config
    

    print(node.Config.TagName, self.Tags)
   -- print(self)
    if handler then handler(self, selectedBlock) end
end)

behaviorRegistry:Register('OnHit', function(self, node) 
    --print(self.Tags) 
    --print('root created', self)
end)

behaviorRegistry:Register('Test', function(self, node)  
    print(2,self.Tags)
end)

behaviorRegistry:Register('Hello', function(self, node)
    --print(node.Additional['OnHit'])
    --print('hello', node.Config)
end)



local parser = test.AbilityParser.new()

local behaviorRegistry2 = test.Registry.new():Clone(behaviorRegistry)

behaviorRegistry2:Register('Root', function(...: any)  
    print('New Root Behavior')
end)

parser.BehaviorRegistry = behaviorRegistry2
parser.ScopeRegistry = scopeRegistry



local ability = parser:Create({
    Name = 'Event.OnHit',
    Tag = 'OnHit12321',
    Children = {
        {
            Name = 'Action.Hello',
            Tag = 'Test',
            RequestedTags = {['OnHit'] = 'OnHit12321'},
            Config = {
                test = 123,
            },
            Children = {
                {
                    Name = 'Action.Test',
                    RequestedTags = {['OnHit'] = 'OnHit12321', ['Parent'] = 'Test'},
                }
            }
        },
    }
})

ability:Build()

ability:Execute(
    {
        Type = 'Action',
        Name = 'TriggerEvent',
        Config = {
            test = 123,
            TagName = 'OnHit12321'
        }
    }
)

-- TreeNode + entryPoint
--[[
self.Additional['OnHit'] = self.Tags['OnHit12321']

]]


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