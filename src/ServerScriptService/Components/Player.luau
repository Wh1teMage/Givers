local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Templates = ReplicatedStorage:WaitForChild("Templates")

local JecsInterfaces = require(ReplicatedStorage.Interfaces.JecsInterfaces)

export type	PlayerInstance = JecsInterfaces.Entity<Player>

return {'PlayerInstance'}