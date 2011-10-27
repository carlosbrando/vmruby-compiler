module VMRuby
  module StackStatement
    def on_dup(args, previous_command, next_command)
      # do nothing
    end
    
    def on_pop(args, previous_command, next_command)
      # "pop eax"
    end
  end
end