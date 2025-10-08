--!strict

local ReplicatedStorage = game:GetService('ReplicatedStorage')
local Interfaces = ReplicatedStorage:WaitForChild('Interfaces')

local BindableInterfaces = require(Interfaces.BindableInterfaces)

local ContainerInterface = require(game.ServerScriptService.GeneratedInterfaces.ContainerInterface)
local PlayerFabricInterface = require(game.ServerScriptService.GeneratedInterfaces.PlayerFabricInterface)


local PlayerSystem = {}
PlayerSystem.__index = PlayerSystem

PlayerSystem.Scope = "Singleton"
PlayerSystem.Inject = {
	Container = "Container",
    PlayerFabric = "PlayerFabric",
    BindableComponent = "BindableComponent"
}

export type Main = { 
    Container: ContainerInterface.IContainer,
    PlayerFabric: PlayerFabricInterface.IPlayerFabric,
    BindableComponent: BindableInterfaces.IBindableComponent,
} & typeof(PlayerSystem) 

function PlayerSystem.new()
	local self = setmetatable({}, PlayerSystem)
	return self
end

function PlayerSystem:Init()
    self = self :: Main

    self.BindableComponent:Connect('PlayerAdded', function(player: Player)
        self.PlayerFabric:CreatePlayer(player)
    end)
end

return PlayerSystem