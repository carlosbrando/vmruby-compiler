module VMRuby
  module VariableStatement
    def on_setlocal(args, previous_command, next_command)
      "pop [#{args[0]}]"
    end
    
    def on_getlocal(args, previous_command, next_command)
      "push [#{args[0]}]"
    end
  end
end