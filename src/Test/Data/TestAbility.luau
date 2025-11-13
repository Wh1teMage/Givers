local parser = require('./../NewPackage/Parser')

return function()
    --[[
    parser.Ability 'test' (function() 
        parser.Debugger 'log' 'test'
        parser.Debugger 'wait' ()
        parser.Debugger 'log' 'test2'
    end)
    ]]

    parser.Ability 'test' (function(context)
        parser.Debugger 'log' (context)
        parser.Debugger 'wait' (function()
            parser.Debugger 'log' 'test2'
        end)
        parser.Debugger 'save' (context, { hi = 'hi' })
        parser.Debugger 'log' (parser.Debugger 'get' (context, 'hi'))
    end)
end