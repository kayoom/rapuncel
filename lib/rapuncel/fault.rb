module Rapuncel
  class Fault
    attr_accessor :code, :string
    
    def initialize hsh
      @code = hsh[:faultCode]
      @string = hsh[:faultString]
    end
  end
end
