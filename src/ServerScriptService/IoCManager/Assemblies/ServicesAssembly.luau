--!strict

local ServerScriptService = game:GetService('ServerScriptService')
local Services = ServerScriptService:WaitForChild('Services')

local requires = {}

for _, object: ModuleScript in pairs(Services:GetChildren()) do
    requires[object.Name] = require(object) :: {}
end

return requires