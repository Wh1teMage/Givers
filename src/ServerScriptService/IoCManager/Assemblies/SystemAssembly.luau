--!strict

local ServerScriptService = game:GetService('ServerScriptService')
local Systems = ServerScriptService:WaitForChild('Systems')

local requires = {}

for _, object: ModuleScript in pairs(Systems:GetChildren()) do
    requires[object.Name] = require(object) :: {}
end

return requires