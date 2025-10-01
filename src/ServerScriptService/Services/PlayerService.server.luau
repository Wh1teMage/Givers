local ReplicatedStorage = game:GetService('ReplicatedStorage')
local ServerScriptService = game:GetService('ServerScriptService')
local packages = ReplicatedStorage:WaitForChild('Packages')
local Containers = ServerScriptService:WaitForChild('Containers')
local Components = ServerScriptService:WaitForChild('Components')


local Contaier = require(Components:WaitForChild('Container'))

for _,v in pairs(Containers:GetChildren()) do
    if v:IsA('ModuleScript') then
        require(v)
    end
end

local charm = Contaier:get('TestService')
print(charm)
