--!strict

local ServerScriptService = game:GetService('ServerScriptService')
local ServerPackages = ServerScriptService:WaitForChild('ServerPackages')

local profilestore = require(ServerPackages:WaitForChild('profilestore'))

return {
    ProfileStore = profilestore,
}