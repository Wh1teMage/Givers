--!strict

local GlobalInterfaces = require(script.Parent.GlobalInterfaces)

export type IPlayerService = {
	Container: typeof(GlobalInterfaces.Container),
}

return {}
