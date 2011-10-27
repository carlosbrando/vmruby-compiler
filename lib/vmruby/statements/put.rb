module VMRuby
  module PutStatement
    def on_putobject(args, previous_command, next_command)
      "push #{args[0]}"
    end
    
    def on_putnil(args, previous_command, next_command)
      # do nothing
    end
  end
end