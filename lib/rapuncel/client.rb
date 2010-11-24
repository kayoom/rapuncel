require 'rapuncel/adapters/typhoeus_adapter'
require 'rapuncel/connection'

module Rapuncel
  class Client
    attr_accessor :connection
    
    include Adapters::TyphoeusAdapter
    
    
    def initialize configuration = {}
      @connection = init_connection(configuration)
    end
    
    def init_connection configuration = {}
      Connection.new configuration
    end
    
    
    def execute_to_ruby request
      execute(request).to_ruby
    end
    
    def execute request
      
    end
  end
end