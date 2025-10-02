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
local profileStore = require(ServerPackages:WaitForChild('profilestore'))
local testez = require(Packages:WaitForChild('testez'))
local janitor = require(Packages:WaitForChild('janitor'))


local Services = {}

export type IServices = {
	Charm: () -> typeof(charm),
    CharmSync: () -> typeof(charmSync),
	React: () -> typeof(react),
	ReactRoblox: () -> typeof(reactRoblox),
	ReactCharm: () -> typeof(reactCharm),
	Ripple: () -> typeof(ripple),
	UiLabs: () -> typeof(uiLabs),
	Sift: () -> typeof(sift),
	T: () -> typeof(t),
	ProfileStore: () -> typeof(profileStore),
	Testez: () -> typeof(testez),
	Janitor: () -> typeof(janitor),
}

Services = {} :: IServices

Services['Charm'] = function()
    return charm
end

Services['CharmSync'] = function()
    return charmSync
end

Services['React'] = function()
    return react
end

Services['ReactRoblox'] = function()
    return reactRoblox
end

Services['ReactCharm'] = function()
    return reactCharm
end

Services['Ripple'] = function()
    return ripple
end

Services['UiLabs'] = function()
    return uiLabs
end

Services['Sift'] = function()
    return sift
end

Services['T'] = function()
    return t
end

Services['ProfileStore'] = function()
    return profileStore
end

Services['Testez'] = function()
    return testez
end

Services['Janitor'] = function()
    return janitor
end

return Services