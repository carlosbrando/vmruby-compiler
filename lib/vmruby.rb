require "vmruby/version"

# Load ASTs
Dir[File.join(File.dirname(__FILE__), 'vmruby', 'ast', '*')].each do |file|
  require "vmruby/ast/" + File.basename(file, ".rb")
end

module VMRuby
  class ASMBuilder
    # include Method, Assignment, Identifier, Literal
    
    attr_accessor :source, :current_line

    def initialize(source)
      self.source = RubyVM::InstructionSequence.compile(source).to_a.last
    end

    def parse
      asm = process(self.source)
      asm << ["leave:"]
      return asm
    end

    def on_trace(args)
      # do nothing
    end
    
    def on_putobject(args)
      "push #{args[0]}"
    end

    def on_setlocal(args)
      "pop [#{args[0]}]"
    end

    def on_putnil(args)
      # do nothing
    end
    
    def on_getlocal(args)
      "push [#{args[0]}]"
    end

    def on_send(args)
      case args[0]
        when :puts
          [
            "pop eax",
            "prn eax"
          ]
        else
          raise "error"
      end
    end
    
    def on_leave(args)
      "jmp leave"
    end

    def method_missing(meth, *args, &blk)
      "#{meth}, #{args.flatten}"
    end

   private
    def process(source)
      result = []
      
      source.each do |command|
        if command.is_a?(Integer)
          self.current_line = command
        else
          token = command.shift
          result << send("on_#{token}", command)
        end
      end
      
      return result.flatten.compact
    end
    
  end
end
