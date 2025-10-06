--!strict

local ServerScriptService = game:GetService('ServerScriptService')
local Services = ServerScriptService:WaitForChild('Services')

local PlayerService = require(Services.PlayerService)

return {
  PlayerService = PlayerService,
}