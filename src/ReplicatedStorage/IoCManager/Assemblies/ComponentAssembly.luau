--!strict

local ServerScriptService = game:GetService('ReplicatedStorage')
local Components = ServerScriptService:WaitForChild('Components')

local requires = {}

for _, object: ModuleScript in pairs(Components:GetChildren()) do
    requires[object.Name] = require(object) :: {}
end

return requires