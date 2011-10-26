require "../lib/vmruby"
require "pp"

src = <<END
  x = 1
  puts x
END

asm = VMRuby::ASMBuilder.new(src).parse

puts
puts "-" * 30

asm.each do |i|
  puts i
end