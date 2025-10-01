local ReplicatedStorage = game:GetService('ReplicatedStorage')
local packages = ReplicatedStorage:WaitForChild('Packages')
local charm = require(packages:WaitForChild('charm'))

local ServerScriptService = game:GetService('ServerScriptService')
local Components = ServerScriptService:WaitForChild('Components')
local Container = require(Components:WaitForChild('Container'))

Container:registerService('TestService', charm)

return Container