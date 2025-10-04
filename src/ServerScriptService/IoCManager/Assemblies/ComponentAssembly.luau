--!strict

local ServerScriptService = game:GetService('ServerScriptService')
local Components = ServerScriptService:WaitForChild('Components')

local EntityComponent = require(Components.EntityComponent)
local PlayerComponent = require(Components.PlayerComponent)
local DataComponent = require(Components.PlayerComponent.DataComponent)

return {
  EntityComponent = EntityComponent,
  PlayerComponent = PlayerComponent,
  DataComponent = DataComponent,
}