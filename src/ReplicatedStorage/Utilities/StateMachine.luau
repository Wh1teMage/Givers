--!strict
local JecsInterfaces = require(game.ReplicatedStorage.Interfaces.JecsInterfaces)

local StateMachine = {}

StateMachine.Scope = "Prototype"
StateMachine.Inject = {}

export type Main = typeof(StateMachine) & {
	Transitions: transitions
}

type Dependencies = {}

type transitions = {[string]: {[string]: boolean}}

type self = Dependencies & Main

function StateMachine.new(transitions: transitions)
	local self = setmetatable({}, { __index = StateMachine })

	self.Transitions = transitions

	return self
end

function StateMachine:canMutate(from: string, to: string)
	self = self :: self

	if (from == to) then return false end
	if (not self.Transitions[from]) then return false end

	return self.Transitions[from][to] or false
end

function StateMachine:Mutate(
	world: JecsInterfaces.World, 
	entity: JecsInterfaces.Entity, 
	component: JecsInterfaces.Entity<{State: string}>, 
	state: string)

	self = self :: self
	local componentData = world:get(entity, component)
	assert(componentData)

	local mutationResult = self:canMutate(componentData.State, state)
	if (not mutationResult) then warn('cant be mutated') end

	componentData.State = state -- check if componentData is a tableRef instead of deepClone
	-- otherwise change to world:set
end

return StateMachine
