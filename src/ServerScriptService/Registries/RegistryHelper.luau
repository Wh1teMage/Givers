--!strict
local RegistryHelper = {}
RegistryHelper.__index = RegistryHelper

RegistryHelper.Scope = "Prototype"
RegistryHelper.Inject = {}

export type Main<T> = {
    storage: {[string]: T},
    Get: (self: Main<T>, name: string) -> T,
} -- add other methods here / change the solution entirely, so it works with typeof(RegistryHelper)

type Dependencies = {}

type self = Dependencies & Main<any>

local function scanFolder(folder: Folder, modules: {[string]: any})
    for _, child in pairs(folder:GetChildren()) do
        if (child:IsA('Folder')) then scanFolder(child, modules); continue end
        if (not child:IsA('ModuleScript')) then continue end
        
        local data = require(child) :: any

        --if (type(data) == 'table' )

        modules[child.Name] = data
    end
end

function RegistryHelper.new()
	local self = setmetatable({}, RegistryHelper)
    self.storage = {}
	return self
end

function RegistryHelper:Get(name: string)
	self = self :: self
    return self.storage[name] 
end

function RegistryHelper:Has(name: string)
	self = self :: self
    return self.storage[name] ~= nil
end

function RegistryHelper:Register(name: string, callback: any) 
    self = self :: self
    if (self.storage[name]) then warn(name..' already exists!'); return self.storage[name] end

    self.storage[name] = callback
    return self.storage[name]
end

-- i feel lazy, if anyone want to rewrite this function into a separate class - go on
function RegistryHelper:LoadFromFolder(folder: Folder)
    local modules = {}
    scanFolder(folder, modules)
end

return RegistryHelper
