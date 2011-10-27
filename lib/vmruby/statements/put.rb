module VMRuby
  module PutStatement
    def on_putobject(args)
      "push #{args[0]}"
    end
    
    def on_putnil(args)
      # do nothing
    end
  end
end