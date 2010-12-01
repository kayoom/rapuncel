module Rapuncel
  class Fault < Exception
    attr_accessor :code, :string
    
    def initialize hsh
      @code = hsh[:faultCode]
      @string = hsh[:faultString]
    end
  end
end
