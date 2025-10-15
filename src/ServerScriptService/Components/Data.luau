local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Templates = ReplicatedStorage:WaitForChild("Templates")

local JecsInterfaces = require(ReplicatedStorage.Interfaces.JecsInterfaces)
local ProfileData = require(Templates:WaitForChild("DataProfile"))()

type DataType = typeof(ProfileData)
type ValuesType = typeof(ProfileData.Values)
type InventoryType = typeof(ProfileData.Inventory)
type MultipliersType = typeof(ProfileData.Multipliers)

export type Data = JecsInterfaces.Entity<DataType>
export type Values = JecsInterfaces.Entity<ValuesType>
export type Multipliers = JecsInterfaces.Entity<MultipliersType>
export type Inventory = JecsInterfaces.Entity<InventoryType>
export type ProfileLink = JecsInterfaces.Entity<>

return {'Data', 'Values', 'Multipliers', 'Inventory', 'ProfileLink'}