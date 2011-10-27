require "../lib/vmruby"

src = <<END
  print 10
END

puts VMRuby::ASMBuilder.new(src).parse

# puts
# puts "-" * 30
# 
# asm.each do |i|
#   puts i
# end