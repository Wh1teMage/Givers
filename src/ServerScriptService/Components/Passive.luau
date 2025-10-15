local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Templates = ReplicatedStorage:WaitForChild("Templates")

local JecsInterfaces = require(ReplicatedStorage.Interfaces.JecsInterfaces)
local ProfileData = require(Templates:WaitForChild("DataProfile"))()

local PassiveTemplate = require(Templates:WaitForChild("Passive"))()

type DataType = typeof(PassiveTemplate.Data)

export type	Data = JecsInterfaces.Entity<DataType>
export type Passive = JecsInterfaces.Entity<>

return {'Data', 'Passive'}