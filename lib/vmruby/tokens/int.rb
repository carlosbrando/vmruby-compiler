module VMRuby
  class Int < Token
    def initialize(sexp)
      sexp = sexp.flatten
      
      @token  = sexp.shift.to_i
      @line   = sexp.shift
      @column = sexp.shift
    end
  end
end