module VMRuby
  class ASMBuilder
    module Method
      def on_def(sexp)
        scope = VMRuby::Scope.new(sexp.first, @current_scope)

        create_scope(scope)
          process(sexp)
        destroy_scope(scope)
      end
    end
  end
end