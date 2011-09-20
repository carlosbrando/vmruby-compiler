require "../lib/vmruby"
require "ripper"
require "ap"
require "pp"

src = <<END
  x = 1

  def teste
    x = 10
    puts x
  end

  x = 2
  z = 3
END

pp exp = Ripper.sexp(src)

puts
puts "---"
puts

puts VMRuby::ASMBuilder.new(exp).parse