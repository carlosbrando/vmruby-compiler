require "vmruby/version"

# Load ASTs
Dir[File.join(File.dirname(__FILE__), 'vmruby', 'statements', '*')].each do |file|
  require "vmruby/statements/" + File.basename(file, ".rb")
end

module VMRuby
  class ASMBuilder
    include VMRuby::SettingStatement, VMRuby::PutStatement,   VMRuby::VariableStatement,
            VMRuby::MethodStatement,  VMRuby::StackStatement, VMRuby::OptimizeStatement,
            VMRuby::JumpStatement
    
    attr_accessor :source, :current_line, :position

    def initialize(source)
      self.source = RubyVM::InstructionSequence.compile(source).to_a.last
    end

    def parse
      asm = process(self.source)
      asm << ["leave:"]
      return asm
    end

    def method_missing(meth, *args, &blk)
      "*** Unknown: #{meth}, #{args.flatten} ***"
    end

   private
    def process(source)
      result = []
      self.position = 0
      
      while self.position < source.size
        previous_command = source[self.position - 1]
        current_command  = source[self.position]
        next_command     = source[self.position + 1]

        if current_command.is_a?(Integer)
          self.current_line = current_command
        elsif current_command.is_a?(Symbol)
          result << "#{current_command}:"
        else
          args  = current_command
          token = args.shift
          result << send("on_#{token}", args, previous_command, next_command)
        end
        
        self.position += 1
      end
      
      return result.flatten.compact
    end
    
  end
end
