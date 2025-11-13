local fs = require('@lune/fs')

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

setmetatable(module, {
    __call = function(t, i)
        return t[i]
    end,

    __index = function(_, i)
        return loadedModules[i]
    end
})

return module