local task = require('@lune/task')

local module = {}

function module.log(...)
    print(...)
end

--[[
module.wait = setmetatable({}, {
    __call = function(t, args)
        task.wait(2)
    end
})
]]

function module.wait(callback)
    task.wait(2)
    callback()
end

function module.save(context, table)
    for index, value in pairs(table) do
        context[index] = value
    end
end

function module.get(context, key)
    return context[key]
end


return module