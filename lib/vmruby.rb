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
    
    attr_accessor :source, :current_line, :position, :complex_types, :current_scope, :scopes, :variable_count

    def initialize(source)
      self.complex_types = []
      self.source = RubyVM::InstructionSequence.compile(source).to_a.last
      
      self.current_scope = :start
      self.scopes = {}
      self.variable_count = 0
    end

    def parse
      methods = parse_methods
      asm = ["start:", process(self.source)]
      asm << ["leave:"]

      return [self.complex_types, "\n", methods, asm]
    end

    def parse_methods
      methods = self.source.select { |e| e.is_a?(Array) && e.first == :putiseq }
      methods.collect do |e|
        name = e.last[5]
        asm  = process(e.last.last)
        asm.pop
        asm << "\tret"
        
        ["#{name}:", asm, "\n"]
      end
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
          # result << [" ", "line_#{self.current_line}:"]
        elsif current_command.is_a?(Symbol)
          result << "#{current_command}:"
        else
          args  = current_command.dup
          token = args.shift
          result << send("on_#{token}", args, previous_command, next_command)
        end
        
        self.position += 1
      end
      
      return result.flatten.compact.collect { |e| "\t#{e}" }
    end
    
  end
end
