require "vmruby/version"

# Load ASTs
Dir[File.join(File.dirname(__FILE__), 'vmruby', 'statements', '*')].each do |file|
  require "vmruby/statements/" + File.basename(file, ".rb")
end

module VMRuby
  class ASMBuilder
    include VMRuby::SettingStatement, VMRuby::PutStatement, VMRuby::VariableStatement,
            VMRuby::MethodStatement,  VMRuby::StackStatement
    
    attr_accessor :source, :current_line

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
      
      source.each do |command|
        if command.is_a?(Integer)
          self.current_line = command
        else
          result << send("on_#{command.shift}", command)
        end
      end
      
      return result.flatten.compact
    end
    
  end
end
