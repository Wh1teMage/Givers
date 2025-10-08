--!strict

local ReplicatedStorage = game:GetService('ReplicatedStorage')
local Packages = ReplicatedStorage:WaitForChild('Packages')

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

local jecs = require(Packages:WaitForChild('jecs'))
local promise = require(Packages:WaitForChild('typed-luau-promise'))
local jabby = require(Packages:WaitForChild('jabby'))
local planck = require(Packages:WaitForChild('planck'))

return {
    Charm = charm,
    CharmSync = charmSync,
    React = react,
    ReactRoblox = reactRoblox,
    ReactCharm = reactCharm,
    Ripple = ripple,
    UiLabs = uiLabs,
    Sift = sift,
    T = t,
    Testez = testez,
    Janitor = janitor,

    Jecs = jecs,
    Promise = promise,
    Jabby = jabby,
    Planck = planck,
}