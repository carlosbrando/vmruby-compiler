module VMRuby
  module JumpStatement

    def on_jump(args, previous_command, next_command)
      "jmp #{args[0]}"
    end

    def on_branchif(args, previous_command, next_command)
      "je #{args[0]}"
    end

    def on_branchunless(args, previous_command, next_command)
      "jne #{args[0]}"
    end
    
  end
end