export type IBindableMethods = {
	Connect: (self: any, name: string, callback: (...any) -> ()) -> (),
	GetConnections: (self: any, name: string) -> { (...any) -> () },
	Once: (self: any, name: string, callback: (...any) -> ()) -> (),
	Wait: (self: any, name: string, callback: {}, time: number) -> (),
	DisconnectAll: (self: any) -> (),
	Destroy: (self: any) -> (),
	Fire: (self: any, name: string, data: any) -> (),
}

export type IBindableComponent = IBindableMethods & {
	connections: { (...any) -> () },
	once: { [string]: any },
	middleware: { [number]: (...any) -> () },
}

return {}
