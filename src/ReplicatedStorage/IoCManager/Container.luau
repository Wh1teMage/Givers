-- Container.luau
--!strict

local ignoreList = { 'Promise' }

local Container = {}
Container.__index = Container

Container.Scope = "Singleton"

export type Registry = { [string]: any } -- registry maps names -> module table (class-like modules)

-- Generic get: возвращает T, но Luau не выведет маппинг ключ->тип, поэтому используем явный generic в местах вызова
function Container.new(registry: Registry)
    local self = setmetatable({
        _registry = registry or {},
        _singletons = {}, -- name -> instance
        _constructing = {}, -- detection cyclic deps
    }, Container)

    self._registry['Container'] = Container
    self._singletons['Container'] = self

    return self
end

-- internal: создаёт новый экземпляр (без кеширования)
function Container:_createInstance(name: string)
    local mod = self._registry[name]
    assert(mod, ("No registered component '%s'"):format(name))

    -- protect from direct cycles
    if self._constructing[name] then
        error(("Cyclic dependency detected while constructing %s"):format(name))
    end
    self._constructing[name] = true

    -- резолв зависимостей, заданных в модуле через таблицу `Inject` (field -> dependencyName)
    local injectSpec = mod.Inject or {}
    local resolvedDeps = {}

    for field, depName in pairs(injectSpec) do
        -- depName может быть строкой ("Announcer") либо таблицей { name = "...", as = "..." } — но у нас упрощённый вариант
        resolvedDeps[field] = self:get(depName)
    end

    -- Создаём объект: если модуль содержит конструктор new(deps, ...)

    local obj
    if (type(mod.new) == "function" and (not table.find(ignoreList, name))) then
        -- многие модули принимают deps таблицу: передаём resolvedDeps
        obj = mod.new()
    else
        -- fallback: если модуль просто таблица с методами, копируем как объект
        obj = setmetatable({}, { __index = mod })
    end
    
    -- внедряем поля непосредственно (вдобавок к конструкторам)
    for field, dep in pairs(resolvedDeps) do
        obj[field] = dep
    end

    --[[
    if (type(mod.Init) == "function") then
        mod:Init()
    end
    ]]

    self._constructing[name] = nil
    return obj
end

-- public get: поддерживает Singleton/Prototype по модулю.Scope
function Container:get<T>(name: string): T
    -- Singleton cache
    local cached = self._singletons[name]
    if cached ~= nil then
        return cached :: T
    end

    local mod = self._registry[name]
    assert(mod, ("Component '%s' is not registered in container"):format(name))

    local scope = mod.Scope or "Prototype"
    local instance = self:_createInstance(name) :: T

    if scope == "Singleton" then
        self._singletons[name] = instance
    end

    return instance
end

function Container:createWithArgs(name: string, args: {[any]: any})
    local instance = self:get(name)

    for key, value in pairs(args) do
        instance[key] = value
    end

    return instance
end

-- register runtime (для динамической регистрации, тестов)
function Container:register(name: string, moduleTable: any)
    self._registry[name] = moduleTable
end

-- support override in tests
function Container:override(name: string, moduleTable: any)
    if self._singletons[name] then
        self._singletons[name] = nil
    end
    self._registry[name] = moduleTable
end

function Container:TreeSorted(name,temp)

    for _,v in pairs(self._singletons[name]['Inject']) do 
        local module = self._singletons[v]
        if (not module) or (not module['Init']) or (temp[v]) then continue end
        temp[v] = true
        module['Init'](module)
    end

    return temp
end

function Container:resolveInitOrder()
    local temp = {}

    for name,_ in pairs(self._registry) do 
        self:get(name)
    end

    for name,module in pairs(self._singletons) do
        if (not module['Init']) or temp[name] then continue end
        temp[name] = true
        temp = self:TreeSorted(name,temp)
        module['Init'](module)
    end 
    
end

return Container
