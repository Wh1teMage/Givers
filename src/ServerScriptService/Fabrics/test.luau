--!strict
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local Interfaces = ServerScriptService.GeneratedInterfaces

local PackagesInterfaces = require(ReplicatedStorage.Interfaces.PackagesInterfaces)
local WorldServiceInterface = require(Interfaces:WaitForChild("WorldServiceInterface"))

local test = {}

test.Scope = "Singleton"
test.Inject = {
	WorldService = "WorldService",
	Jecs = "Jecs",
}

export type Main = {
	WorldService: WorldServiceInterface.IWorldService,
	Jecs: typeof(PackagesInterfaces.Jecs),
} & typeof(test)

function test.new()
	local self = setmetatable({}, { __index = test })
	return self
end

function test:Init()
	self = self :: Main
end

function test:LoadProfile()
	self = self :: Main
end

return test
