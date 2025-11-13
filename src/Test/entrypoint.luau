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
    local behavior = self.BehaviorRegistry:Get(node.Name)
    if (behavior) then behavior(self, node) end

    self.Events[node.Name] = node
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

--ability:FireEvent('Test', {tst = 123})

--print(ability)

--print(test)