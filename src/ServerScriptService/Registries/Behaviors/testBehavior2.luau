return function(world, args, entity)
    local delay = args['delay'] :: number
    local state = args['changeTo'] :: string

    -- how do i add components here
    -- args wont wont both as argument or as a variable
    -- require also wont work

    -- i could use
    --[[
    
    behaviorFunction(world, behavior.args, abilityEntity)

    but pass this as params

    {
        ['world'] = world,
        ['args'] = behavior.args,
        ['entity'] = abilityEntity,
        ['componentFabric'] = ComponentFabric,
    }

    ]]

    task.delay(delay, function()
        print(state)
    end)
end