module VMRuby
  class Scope < Token
    attr_accessor :parent, :variables
    
    def initialize(sexp, parent)
      sexp = sexp.flatten
      
      @token  = sexp.shift
      @line   = sexp.shift
      @column = sexp.shift
      
      @parent = parent
      @variables = {}
    end
  end
end