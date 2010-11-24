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
    
    def call name, *args
      execute Request.new(name, *args)
    end
    
    def execute_to_ruby request
      execute(request).to_ruby
    end
    
    def execute request
      Response.new send_body(request.to_xml_rpc)
    end
  end
end