module VMRuby
  class ASMBuilder
    module Literal
      def on_int(sexp)
        VMRuby::Int.new(sexp)
      end
    end
  end
end