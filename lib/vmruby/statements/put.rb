module VMRuby
  module PutStatement
    def on_putobject(args, previous_command, next_command)
      "push #{args[0]}"
    end
    
    def on_putnil(args, previous_command, next_command)
      # do nothing
    end
    
    def on_putstring(args, previous_command, next_command)
      name = ".LC#{self.complex_types.size}"
      self.complex_types << ["#{name}:", ".string \"#{args[0]}\""]
      "push #{name}"
    end
  end
end