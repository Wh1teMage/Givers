--!strict

local ServerScriptService = game:GetService('ServerScriptService')
local Registries = ServerScriptService:WaitForChild('Registries')

local requires = {}

for _, object: ModuleScript in pairs(Registries:GetChildren()) do
    if (not object:IsA('ModuleScript')) then continue end
    requires[object.Name] = require(object) :: {}
end

return requires