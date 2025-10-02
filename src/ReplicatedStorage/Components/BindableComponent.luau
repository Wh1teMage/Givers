--!strict

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")

local Interfaces = ReplicatedStorage:WaitForChild("Interfaces")
local Components = ServerScriptService:WaitForChild("Components")

local BindableInterfaces = require(Interfaces:WaitForChild("BindableInterfaces"))
local Container = require(Components:WaitForChild("ServiceContainer"))

local BindableComponent = {}

local Sift = Container.Sift()

-- Импорт интерфейса

local Signals = {}

local Methods = {}

function BindableComponent.new(scope: string): BindableInterfaces.IBindableComponent
	local component = setmetatable({
		connections = {},
		onceConnections = {},
		middlewares = {},
	}, Methods)

	Signals[scope] = component

	return component :: any
end

function Methods:Connect(name: string, callback: (...any) -> ())
	self = self :: BindableInterfaces.IBindableComponent

	if not self.connections[name] then
		self.connections[name] = {}
	end

	table.insert(self.connections[name], callback)
end

function Methods:GetConnections(name: string): { (...any) -> () }
	self = self :: BindableInterfaces.IBindableComponent

	return self.connections[name]
end

function Methods:Once(name: string, callback: (...any) -> ())
	self = self :: BindableInterfaces.IBindableComponent

	self.onceConnections[name] = function()
		self.onceConnections[name] = nil
		callback()
	end
end

function Methods:Wait(name: string, callback: (...any) -> (), time: number?)
	self = self :: BindableInterfaces.IBindableComponent

	self:Once(name, callback)
	local start = os.clock()

	while self.onceConnections[name] and (os.clock() - start) < (time or 5) do
		task.wait(2/60)
	end
end

function Methods:DisconnectAll()
	self = self :: BindableInterfaces.IBindableComponent

	for name, connect in pairs(self.connections) do
		table.clear(connect)
		self.connections[name] = {}
	end

	for name, _ in pairs(self.onceConnections) do
		self.onceConnections[name] = nil
	end

	for name, _ in pairs(self.middlewares) do
		self.middlewares[name] = nil
	end
end

function Methods:Destroy()
	self = self :: BindableInterfaces.IBindableComponent

	self:DisconnectAll()

	for _, data in pairs(self) do
		if (typeof(data) ~= 'table') then continue end
		table.clear(data)
	end

	setmetatable(self, nil)
end

function Methods:AddMiddleware(name: string, callback: (...any) -> ())
	self = self :: BindableInterfaces.IBindableComponent
	self.middlewares[name] = callback
end

function Methods:Fire(eventName: string, payload: any)
	self = self :: BindableInterfaces.IBindableComponent

	assert(self.connections[eventName], `{eventName} doent exist`)

	local context = { name = eventName, data = payload }

	if (self.middlewares[eventName]) then
		self.middlewares[eventName](context)
	end

	if (self.onceConnections[eventName]) then
		self.onceConnections[eventName](context)
	end

	for _, connection in pairs(self.connections[eventName]) do
		connection(context)
	end

end

return BindableComponent
