local ServerScriptService = game:GetService('ServerScriptService')
local ReplicatedStorage = game:GetService('ReplicatedStorage')

local ServerAssemblies = ServerScriptService:WaitForChild('Assemblies')
local ClientAssemblies = ReplicatedStorage:WaitForChild('Assemblies')

local ComponentAssembly = require(ServerAssemblies.ComponentAssembly)

local ClientPackageAssembly = require(ClientAssemblies.ClientPackageAssembly)
local ServerPackageAssembly = require(ServerAssemblies.ServerPackageAssembly)

local EntityContainer = {}
EntityContainer.__index = EntityContainer

function EntityContainer.new() 
    local self = setmetatable({}, EntityContainer)

    self.EntityComponent = function() 
        return ComponentAssembly.EntityComponent.new({})
    end

    return self
end

return EntityContainer