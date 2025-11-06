--!strict

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Interfaces = ReplicatedStorage:WaitForChild("Interfaces")

--local BindableInterfaces = require(Interfaces:WaitForChild("BindableInterfaces"))

local PackagesInterfaces = require(Interfaces.PackagesInterfaces)

local BindableComponent = {}

BindableComponent.Scope = 'Prototype'
BindableComponent.Inject = {
	Promise = 'Promise',
}

export type Main = typeof(BindableComponent) & {
	connections: {},
	onceConnections: {},
	middlewares: {},
} & {
	Promise: typeof(PackagesInterfaces.Promise)
}

function BindableComponent.new()
	local component = setmetatable({
		connections = {},
		onceConnections = {},
		middlewares = {},
	}, {})

	return component
end

function BindableComponent:Connect(name: string, callback: ({[string]: any}) -> ())
	self = self --:: BindableInterfaces.IBindableComponent

	if not self.connections[name] then
		self.connections[name] = {}
	end

	table.insert(self.connections[name], callback)
end

function BindableComponent:GetConnection(name: string, scope: string)
	if not self[scope][name] then
		return
	end
	return self[scope][name]
end

function BindableComponent:GetConnections(name: string): { ({[string]: any}) -> () }
	self = self --:: BindableInterfaces.IBindableComponent

	return self.connections[name]
end

function BindableComponent:Once(name: string, callback: ({[string]: any}) -> ())
	self = self --:: BindableInterfaces.IBindableComponent

	self.onceConnections[name] = function(...)
		self.onceConnections[name] = nil
		callback(...)
	end

	
end

function BindableComponent:Wait(name: string, timeout: number?)
	self = self :: Main

	if (not timeout) then timeout = 5 end
	


	local promise = self.Promise.new(function(resolve, reject, cancel)

		self:Once(name, function(context)
			resolve(context)
		end)

		cancel(function()
			self.onceConnections[name] = nil
			reject("Cancelled")

			return true
		end)


		task.delay(timeout, function()
			if (not self.onceConnections[name]) then return end

			self.onceConnections[name] = nil
			reject(`Timeout of {timeout} seconds waiting for {name}`)
		end)
	end)

	return promise
end

function BindableComponent:DisconnectAll()
	self = self --:: BindableInterfaces.IBindableComponent

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

function BindableComponent:Destroy()
	self = self --:: BindableInterfaces.IBindableComponent

	self:DisconnectAll()

	for _, data in pairs(self) do
		if (typeof(data) ~= 'table') then continue end
		table.clear(data)
	end

	setmetatable(self, nil)
end

function BindableComponent:AddMiddleware(name: string, callback: ({[string]: any}) -> ())
	self = self --:: BindableInterfaces.IBindableComponent
	self.middlewares[name] = callback
end

function BindableComponent:Fire(eventName: string, payload: {[string]: any})
	self = self --:: BindableInterfaces.IBindableComponent

	assert(self.connections[eventName], `{eventName} doent exist`)

	local context = { name = eventName, data = payload }

	if (self.middlewares[eventName]) then
		self.middlewares[eventName](context)
	end

	if (self.onceConnections[eventName]) then
		self.onceConnections[eventName](context.data)
	end

	for _, connection in pairs(self.connections[eventName]) do
		connection(context.data)
	end

end

return BindableComponent
