module VMRuby
  module MethodStatement    
    def on_send(args)
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
   
    def on_leave(args)
      "jmp leave"
    end 
  end
end