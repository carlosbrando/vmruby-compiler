module VMRuby
  module VariableStatement
    def on_setlocal(args, previous_command, next_command)
      "pop [#{variable_position(args[0])}]"
    end
    
    def on_getlocal(args, previous_command, next_command)
      scope = self.scopes[self.current_scope]
      
      "push [#{variable_position(args[0])}]"
    end
    
   private
    def variable_position(ruby_position)
      if self.scopes.keys.include?("#{self.current_scope}_#{ruby_position}")
        return self.scopes["#{self.current_scope}_#{ruby_position}"]
      else
        vm_position = self.variable_count
        self.scopes["#{self.current_scope}_#{ruby_position}"] = vm_position
        self.variable_count += 1
        return vm_position
      end
    end
  end
end