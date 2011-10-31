module VMRuby
  module PutStatement
    def on_putobject(args, previous_command, next_command)
      if args[0].is_a?(Symbol) && next_command[0] == :putiseq
        # altera o escopo do projeto
        # "testesteste"
        # self.current_scope = args[0]
        # p "------"
        # p next_command.last.last
        # p "------"
        return []
      else
        "push #{args[0]}"
      end
    end
    
    def on_putnil(args, previous_command, next_command)
      # do nothing
    end
    
    def on_putstring(args, previous_command, next_command)
      name = ".LC#{self.complex_types.size}"
      self.complex_types << ["#{name}:", "\t.string \"#{args[0]}\""]
      "push #{name}"
    end
    
    def on_putself(args, previous_command, next_command)
      # do nothing
    end
    
    def on_putspecialobject(args, previous_command, next_command)
      # do nothing
    end
  end
end