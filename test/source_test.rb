require "../lib/vmruby"
require "pp"

src = <<END
  x = 15
  
  if x == 10 || x > 10
    puts 1
  else
    puts 0
  end
END

asm = VMRuby::ASMBuilder.new(src).parse

puts
puts "-" * 30

asm.each do |i|
  puts i
end