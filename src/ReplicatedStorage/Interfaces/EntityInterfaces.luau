local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Templates = ReplicatedStorage:WaitForChild("Templates")

local SessionData = require(Templates:WaitForChild("SessionData"))

type ISessionData = typeof(SessionData())

export type IEntityMethods = {
	new: () -> IEntityComponent,
}

export type IEntityComponent = IEntityMethods & {
	SessionData: ISessionData,
}

return {}
