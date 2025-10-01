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
		middleware = {},
	}, Methods)
	Signals[scope] = self

	return self
end

function Methods:Connect(name: string, callback: (...any) -> ())
	local self: typeof(self) = self
	if not self.connections[name] then
		self.connections[name] = {}
	end
	table.insert(self.connections[name], callback)
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

function Methods:Wait(name: string, callback: {}, time: number)
	self.Once[name](callback)

	while self.once[name] do
		task.wait(time)
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

function Methods:Fire(name: string, data: any)
	for _, connect in pairs(self.connections) do
		connect["callback"](data)
	end

	for _, once in pairs(self.once) do
		once["callback"](data)
	end
end

return BindableComponent
