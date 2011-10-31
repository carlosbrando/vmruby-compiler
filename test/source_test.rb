require "../lib/vmruby"
require "awesome_print"

src = <<END
def teste
  puts "teste1"
end

def teste2
  puts "teste2"
end

teste2
teste
caramba
END

# ap RubyVM::InstructionSequence.compile(src).to_a

# puts
# puts "-" * 30

asm = VMRuby::ASMBuilder.new(src).parse

asm.each do |i|
  puts i
end