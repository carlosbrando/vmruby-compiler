require File.join(File.dirname(__FILE__), "../lib/vmruby")
# require "awesome_print"

src = <<END
def teste(a)
  b = a + 1
  puts b

  if b < 100
    teste(b)
  end
end


teste(1)
END

# ap RubyVM::InstructionSequence.compile(src).to_a

# puts
# puts "-" * 30

asm = VMRuby::ASMBuilder.new(src).parse

asm.each do |i|
  puts i
end