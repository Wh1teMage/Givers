local fs = require('@lune/fs')
local parser = require('./Parser')

local module = {}


local loadedModules = {}

for _, entry in fs.readDir('./src/Test/NewPackage/Parser') do
    local name = string.split(entry, '.')[1]
    if (name == 'init') then continue end
    loadedModules[name] = require(`./Parser/{name}`)
end

for _, v in pairs(loadedModules) do
    setmetatable(v, {
        __call = function(t, i)
            return t[i]
        end
    })
end

function module.test(callback: (...any) -> nil)
    local self = {
        Parser = parser,
        context = {},
    }

    setmetatable(self, {
        __index = function(_, i)
            if (module[i]) then return module[i] end
            if (parser[i]) then return parser[i] end
            return nil
        end,

        __call = function(_, i)

        end
    })

    callback(self)
end

setmetatable(module, {
    __call = function(t, i)
        return t[i]
    end,

    __index = function(_, i)
        return loadedModules[i]
    end
})

return module