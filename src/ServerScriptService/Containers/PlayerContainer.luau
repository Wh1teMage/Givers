--!strict

local ServerScriptService = game:GetService('ServerScriptService')
local ReplicatedStorage = game:GetService('ReplicatedStorage')
local RunService = game:GetService('RunService')

local ServerAssemblies = ServerScriptService:WaitForChild('Assemblies')
local ClientAssemblies = ReplicatedStorage:WaitForChild('Assemblies')

local ComponentAssembly = require(ServerAssemblies.ComponentAssembly)

local ClientPackageAssembly = require(ClientAssemblies.ClientPackageAssembly)
local ServerPackageAssembly = require(ServerAssemblies.ServerPackageAssembly)

local PlayerContainer = {}
PlayerContainer.__index = PlayerContainer

function PlayerContainer.new()
    local self = setmetatable({}, PlayerContainer)

    self.DataComponent = function(player: Player)
        local profile = ServerPackageAssembly.ProfileStore

        return ComponentAssembly.DataComponent.new({ 
            ProfileStore = profile,
            Sift = ClientPackageAssembly.Sift,
        }, player)
    end

    self.PlayerComponent = function(player: Player)
        return ComponentAssembly.PlayerComponent.new({
            Entity = PlayerContainer._entity(),
            Data = self.DataComponent(player)
        }, player)
    end

    return self
end

PlayerContainer._entity = function() warn('entity constructor not defined') end

return PlayerContainer
