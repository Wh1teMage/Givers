--!strict

local ServerScriptService = game:GetService('ServerScriptService')
local Fabrics = ServerScriptService:WaitForChild('Fabrics')

local PlayerFabric = require(Fabrics.PlayerFabric)

return {
    PlayerFabric = PlayerFabric
}