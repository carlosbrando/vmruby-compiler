module VMRuby
  class ASMBuilder
    module Assignment
      def on_assign(sexp)
        variable, value = process(sexp)
        variable_number = create_variable(variable.token)
        @asm << "mov [#{variable_number}], #{value.token}"
      end
    end
  end
end