module VMRuby
  module MethodStatement    
    def on_send(args, previous_command, next_command)
      case args[0]
        when :puts
          [
            "pop eax",
            "prn eax"
          ]
        when :"core#define_method"
          # do nothing
        else
          "call #{args[0]}"
      end
    end
   
    def on_leave(args, previous_command, next_command)
      "jmp leave"
    end
    
    def on_putiseq(args, previous_command, next_command)
      # do nothing
    end
  end
end