local Intefaces = script.Parent
local PackagesInterfaces = require(Intefaces.PackagesInterfaces)

type Promise = typeof(PackagesInterfaces.Promise)

export type IBindableMethods = {
	Connect: (self: any, name: string, callback: (...any) -> ()) -> (),
	GetConnections: (self: any, name: string) -> { (...any) -> () },
	GetConnection: (self: any, name: string, scope: string) -> any,
	Once: (self: any, name: string, callback: (...any) -> ()) -> (),
	Wait: (self: any, name: string, callback: (...any) -> (), time: number?) -> (),
	DisconnectAll: (self: any) -> (),
	Destroy: (self: any) -> (),
	AddMiddleware: (self: any, func: (...any) -> ()) -> (),
	Fire: (self: any, name: string, data: any) -> (),
}

export type IBindableComponent = IBindableMethods & {
	connections: { [string]: { (...any) -> () }},
	onceConnections: { [string]: (...any) -> () },
	middlewares: { [string]: (...any) -> () },

	Promise: Promise,
}

return {}
