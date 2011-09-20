module VMRuby
  class ASMBuilder
    module Identifier
      def on_ident(sexp)
        VMRuby::Ident.new(sexp)
      end
    end
  end
end