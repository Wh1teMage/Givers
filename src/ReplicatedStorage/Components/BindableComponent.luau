local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Interfaces = ReplicatedStorage:WaitForChild("Interfaces")
local BindableInterfaces = require(Interfaces:WaitForChild("BindableInterfaces"))

local BindableComponent = {}

-- Импорт интерфейса

local Signals = {}

local Methods = {}

function BindableComponent.new(scope: string): BindableInterfaces.IBindableComponent
	local self = setmetatable({
		connections = {},
		once = {},
		middlewares = {},
	}, Methods)
	Signals[scope] = self

	return self
end

function Methods:Connect(name: string, callback: (...any) -> ())
	self = self :: typeof(self)
	if not self.connections[name] then
		self.connections[name] = {}
	end
	table.insert(self.connections[name], callback)
end

function Methods:GetConnection(name: string, scope: string)
	if not self[scope][name] then
		return
	end
	return self[scope][name]
end

function Methods:GetConnections(name: string): { (...any) -> () }
	return self.connections[name]
end

function Methods:Once(name: string, callback: (...any) -> ())
	self.once[name] = function()
		self.once[name] = nil
		callback()
	end
end

function Methods:Wait(name: string, callback: {}, Time: number)
	self.Once[name](callback)

	while self.once[name] do
		task.wait(Time or 1)
	end
end

function Methods:DisconnectAll()
	for _, connect in pairs(self.connections) do
		connect = nil
	end

	for _, once in pairs(self.once) do
		once = nil
	end
end

function Methods:Destroy()
	self:DisconnectAll()

	for _, v in pairs(self) do
		v = nil
	end
end

function Methods:AddMiddleware(func: (...any) -> ())
	table.insert(self.middlewares, func)
end

function Methods:Fire(eventName: string, payload: any)
	local ctx = { name = eventName, data = payload }

	for _, mv in ipairs(self.middlewares) do
		mv(ctx)
	end

	local signal = self:GetConnection(eventName)
	signal:Fire(ctx.data)
end

return BindableComponent
