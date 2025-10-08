--!strict
local module = require(game.ServerScriptService.IoCManager.Registry)

export type IContainer = typeof(module.Build())

return {}
