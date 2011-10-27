module VMRuby
  module OptimizeStatement
    def on_opt_gt(args, previous_command, next_command)
      asm = [
        "pop ebx",
        "pop eax",
        "cmp eax, ebx"
      ]
      
      case next_command.first
      when :branchif
        asm << "jg #{next_command[1]}"
      when :branchunless
        asm << "jle #{next_command[1]}"
      else
        puts "***** ERROR: on_opt_gt"
      end
      
      self.position += 1
      return asm
    end

    def on_opt_eq(args, previous_command, next_command)
      [
        "pop ebx",
        "pop eax",
        "cmp eax, ebx" 
      ]
    end

    def on_opt_lt(args, previous_command, next_command)
      asm = [
        "pop ebx",
        "pop eax",
        "cmp eax, ebx"
      ]
      
      case next_command.first
      when :branchif
        asm << "jl #{next_command[1]}"
      when :branchunless
        asm << "jge #{next_command[1]}"
      else
        puts "***** ERROR: on_opt_lt"
      end
      
      self.position += 1
      return asm
    end
    
  end
end