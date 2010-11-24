module Rapuncel
  class Response
    attr_accessor :http_response
    
    # delegate  :body, 
    #           :to => :http_response
    
    def initialize http_response
      @http_response = http_response
    end
    
    def to_ruby
      
    end
  end
end