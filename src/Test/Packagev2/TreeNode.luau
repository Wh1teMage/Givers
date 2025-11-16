-- Tree / Parser utilities used for ability authoring / tests.
-- Comments and TODOs moved near relevant functions. This file exposes
-- Registry, TreeNode, Parser and AbilityParser and exports typed
-- interfaces for each class below their declaration.

local Registry = {}
Registry.__index = Registry

function Registry.new()
    local self = setmetatable({
        callbacks = {},
    }, Registry)

    return self
end

function Registry:Register(name: string, callback: (...any) -> any)
    self.callbacks[name] = callback
end

function Registry:Get(name: string)
    if (not self.callbacks[name]) then
        print(('%s isn\'t registered!'):format(name))
        return nil
    end

    return self.callbacks[name]
end

function Registry:Clone(registry)
    setmetatable(self.callbacks, {
        __index = function(t, i)
            return registry.callbacks[i]
        end
    })

    return self
end

-- Интерфейс для Registry: методы через typeof, поля типизированы вручную
export type IRegistry = {callbacks: { [string]: (...any) -> any }} & typeof(Registry)

local TreeNode = {}
TreeNode.__index = TreeNode

function TreeNode.new(config: any)
    local self = setmetatable({
        Id = (config and config.id) or 1,
        Type = (config and config.type) or nil,
        Name = (config and config.name) or nil,
        Config = config.config or {},
        Children = (config and config.children) or {},
        Parent = nil,
        InjectedCallback = (config and config.callback) or nil,
    }, TreeNode)

    -- ensure parent links for provided children
    for _, child in ipairs(self.Children) do
        if (not child) then continue end
        child.Parent = self
    end

    return self
end

function TreeNode:GetPath(): string
    local path = {}
    local current = self

    while current do
        table.insert(path, 1, (current.Type or "") .. (current.Name or ""))
        current = current.Parent
    end

    -- join with "/" for readability
    return table.concat(path, "/")
end

function TreeNode:GetRoot()
    local current = self

    while current do
        current = current.Parent
    end

    return current
end

function TreeNode:Execute()
    if (not self.InjectedCallback) then return end
    self.InjectedCallback(self)
end

-- Рекурсивный тип узла и интерфейс
export type TreeNodeT = {
    Id: number,
    Type: string?,
    Name: string?,
    Config: any,
    Children: { TreeNodeT },
    Parent: TreeNodeT?,
} & typeof(TreeNode)

local Parser = {}
Parser.__index = Parser

function Parser.new()
    local self = setmetatable({
        ScopeRegistry = Registry.new(),
        Events = {},
        Tree = nil,
    }, Parser)

    return self
end

-- Parse a nodes structure into internal representation.
-- Base implementation: dispatch by node type using ScopeRegistry.
-- Subclasses (AbilityParser, PassiveParser) can extend or override.
--[[
function Parser:Execute(node: TreeNodeT)
    if (not node or not node.Type) then return end

    -- dispatch to scope handler if registered
    local handler = self.ScopeRegistry:Get(node.Type)
    if handler then handler(self, node) end
end
]]

function Parser:TransferIntoNodes()
    -- to be implemented by subclasses
end

-- Интерфейс Parser
export type IParser = {
    BehaviorRegistry: IRegistry,
} & typeof(Parser)

local AbilityParser = {}
AbilityParser.__index = AbilityParser
setmetatable(AbilityParser, { __index = Parser })

function AbilityParser.new()
    local self = setmetatable(Parser.new(), AbilityParser)
    self.BehaviorRegistry = Registry.new()

    return self
end

-- Transfer an ability definition (data-driven) into TreeNode instances.
-- Intended for converting ability.behaviors sequences into a node tree.
function AbilityParser:TransferIntoNodes(structure: any, name: string?)
    local children = {}
    if (not name) then name = 'Default' end
    
    local splitted = string.split(name :: string, '.')
    if (#splitted < 2) then return end

    for key, child in pairs(structure) do
        local childNode = self:TransferIntoNodes(child, key)
        table.insert(children, childNode)
    end

    local rootNode = TreeNode.new({
        type = splitted[1],
        name = splitted[2],
        children = children,
        config = structure.Config,
        callback = self.ScopeRegistry:Get(splitted[1]),
    })

    return rootNode
end

function AbilityParser:Execute(structure: any)
    local block = self:TransferIntoNodes(structure, 'Action.Root')
    block.Execute(self, block)
end

function AbilityParser:Create(structure: any)
    self.Tree = self:TransferIntoNodes(structure, 'Action.Root')
    return self
end

function AbilityParser:Build()
    self.Tree.Execute(self, self.Tree)
end

-- Интерфейс AbilityParser
export type IAbilityParser = {
    BehaviorRegistry: IRegistry,
} & IParser & typeof(AbilityParser)

return {
    Registry = Registry,
    TreeNode = TreeNode,
    Parser = Parser,
    AbilityParser = AbilityParser,
}