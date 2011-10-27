module VMRuby
  module VariableStatement
    def on_setlocal(args)
      "pop [#{args[0]}]"
    end
    
    def on_getlocal(args)
      "push [#{args[0]}]"
    end
  end
end