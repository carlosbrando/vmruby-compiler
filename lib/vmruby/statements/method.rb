module VMRuby
  module MethodStatement    
    def on_send(args, previous_command, next_command)
      case args[0]
        when :puts
          [
            "pop eax",
            "prn eax"
          ]
        else
          "*** Method unknown: #{args[0]} ***"
      end
    end
   
    def on_leave(args, previous_command, next_command)
      "jmp leave"
    end 
  end
end