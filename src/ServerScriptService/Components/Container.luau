local Container = {}
Container.services = {}

function Container:registerService(serviceName: string, serviceModule: any)
    self.services[serviceName] = serviceModule
end

function Container:get(serviceName: string): any
    return self.services[serviceName]
end



return Container