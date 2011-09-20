module VMRuby
  class Ident < Token
    def initialize(sexp)
      sexp = sexp.flatten
      
      @token  = sexp.shift
      @line   = sexp.shift
      @column = sexp.shift
    end
  end
end