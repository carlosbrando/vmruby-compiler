require "vmruby/version"
require "vmruby/token"

# Load tokens
Dir[File.join(File.dirname(__FILE__), 'vmruby', 'tokens', '*')].each do |file|
  require "vmruby/tokens/" + File.basename(file, ".rb")
end

# Load ASTs
Dir[File.join(File.dirname(__FILE__), 'vmruby', 'ast', '*')].each do |file|
  require "vmruby/ast/" + File.basename(file, ".rb")
end

module VMRuby
  class ASMBuilder
    include Method, Assignment, Identifier, Literal
    
    attr_accessor :sexp, :asm, :scopes, :current_scope, :reserved_variables

    def initialize(sexp)
      @sexp = sexp
      @asm  = []
      
      @reserved_variables = []
      @current_scope      = :__main__
      @scopes             = { :__main__ => VMRuby::Scope.new(["__main__", [0, 0]], nil) }
    end

    def parse
      process @sexp
      return @asm
    end

    def method_missing(meth, *args, &blk)
      if meth.to_s.start_with?("on_")
        process(args) unless args.first.empty?
      else
        super
      end
    end

   private
    def process(sexp)
      result = []
      
      sexp.each do |command|
        next unless command.is_a?(Array)
        if command.first.is_a?(Array)
          result << process(command)
        else
          token = command.shift.to_s.gsub('@', '')
          result << send("on_#{token}", command)
        end
      end
      
      result.flatten.compact
    end

    ##########
    # Cria e muda o escopo do programa para um novo escopo
    #
    def create_scope(new_scope)
      @scopes[new_scope.token.to_sym] = new_scope unless @scopes.include?(new_scope.token.to_sym)
      @current_scope = new_scope.token.to_sym
    end
    
    ##########
    # Remove o escopo e volta para o escopo anterior, tomando o cuidado
    # de limpar todas as variáveis utilizadas no escopo
    #
    def destroy_scope(scope)
      # volta para o scope anterior
      @current_scope = scope.parent
      
      # Limpa todas as variaveis usadas no scope
      scope.variables.each do |name, number|
        @asm << "mov [#{number}], 0"
        @reserved_variables.delete(number)
      end
      
      # apaga o scope
      @scopes.delete(scope.token.to_sym)
    end

    ##########
    # Reserva uma nova variavel dentro do escopo atual
    #
    def create_variable(token)
      scope = @scopes[@current_scope]
      
      if scope.variables.include?(token.to_sym)
        number = scope.variables[token.to_sym]
      else
        number = get_next_variable
        scope.variables.merge!(token.to_sym => number)
      end
      
      return number
    end
    
    ##########
    # Devolve o numero da proxima variavel disponivel
    #
    def get_next_variable
      number = 0

      while @reserved_variables.include?(number)
        number += 1
      end
      
      @reserved_variables << number
      return number
    end
    
  end
end
