--!strict

local ReplicatedStorage = game:GetService('ReplicatedStorage')
local ServerScriptService = game:GetService('ServerScriptService')

local Packages = ReplicatedStorage:WaitForChild('Packages')
local ServerPackages = ServerScriptService:WaitForChild('ServerPackages')

local charm = require(Packages:WaitForChild('charm'))
local charmSync = require(Packages:WaitForChild('charm-sync'))
local react = require(Packages:WaitForChild('react'))
local reactRoblox = require(Packages:WaitForChild('react-roblox'))
local reactCharm = require(Packages:WaitForChild('react-charm'))
local ripple = require(Packages:WaitForChild('ripple'))
local uiLabs = require(Packages:WaitForChild('ui-labs'))
local sift = require(Packages:WaitForChild('sift'))
local t = require(Packages:WaitForChild('t'))
local testez = require(Packages:WaitForChild('testez'))
local janitor = require(Packages:WaitForChild('janitor'))

export type PlayerDependecies = {
    ProfileStore: any,
    Sift: any,
}

export type DataDependecies = {
    Entity: any,
    Data: any,
}