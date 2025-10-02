
local EventBus = {}
EventBus.__index = EventBus

function EventBus.new()
    return setmetatable({
        _topics = {},       -- [eventName] = Signal
        _connections = {},  -- [eventName] = {connections}
        _middlewares = {},  -- список middleware
    }, EventBus)
end

-- 🔹 Добавить middleware
function EventBus:AddMiddleware(fn)
    table.insert(self._middlewares, fn)
end

-- 🔹 Получить или создать Signal для события
function EventBus:_getSignal(eventName)
    if not self._topics[eventName] then
        self._topics[eventName] = {}
        self._connections[eventName] = {}
    end
    return self._topics[eventName]
end

-- 🔹 Подписка
function EventBus:Connect(eventName, callback)
    local signal = self:_getSignal(eventName)
    local conn = signal:Connect(callback)

    table.insert(self._connections[eventName], conn)
    return conn
end

-- 🔹 Подписка один раз
function EventBus:Once(eventName, callback)
    local signal = self:_getSignal(eventName)
    local conn
    conn = signal:Connect(function(payload)
        conn:Disconnect()
        callback(payload)
    end)
    table.insert(self._connections[eventName], conn)
    return conn
end

-- 🔹 Yield до события
function EventBus:Wait(eventName)
    local signal = self:_getSignal(eventName)
    return signal:Wait()
end

-- 🔹 Fire (с middleware)
function EventBus:Fire(eventName, payload)
    local ctx = { name = eventName, data = payload }

    for _, mw in ipairs(self._middlewares) do
        mw(ctx) -- middleware может изменить ctx.data
    end

    local signal = self:_getSignal(eventName)
    signal:Fire(ctx.data)
end

-- 🔹 Удалить все подписки для события
function EventBus:DisconnectAll(eventName)
    if self._connections[eventName] then
        for _, conn in ipairs(self._connections[eventName]) do
            conn:Disconnect()
        end
        self._connections[eventName] = {}
    end
end

-- 🔹 Получить все подключения события
function EventBus:GetConnections(eventName)
    return self._connections[eventName] or {}
end

return EventBus
