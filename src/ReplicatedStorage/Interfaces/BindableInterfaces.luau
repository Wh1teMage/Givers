export type IBindableMethods = {
	Connect: (self: any, name: string, callback: (...any) -> ()) -> (),
	GetConnections: (self: any, name: string) -> { (...any) -> () },
	GetConnection: (self: any, name: string, scope: string) -> any,
	Once: (self: any, name: string, callback: (...any) -> ()) -> (),
	Wait: (self: any, name: string, callback: {}, time: number) -> (),
	DisconnectAll: (self: any) -> (),
	Destroy: (self: any) -> (),
	AddMiddleware: (self: any, func: (...any) -> ()) -> (),
	Fire: (self: any, name: string, data: any) -> (),
}

export type IBindableComponent = IBindableMethods & {
	connections: { (...any) -> () },
	once: { [string]: any },
	middlewares: { [number]: (...any) -> () },
}

return {}
