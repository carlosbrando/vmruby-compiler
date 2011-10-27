require "../lib/vmruby"
require "pp"

src = <<END
  puts "hello, world"
  puts "teste"
  # puts 1
  # puts 2
END

asm = VMRuby::ASMBuilder.new(src).parse

puts
puts "-" * 30

asm.each do |i|
  puts i
end