require 'rapuncel/adapters/typhoeus_adapter'
require 'rapuncel/adapters/net_http_adapter'
require 'rapuncel/connection'


module Rapuncel
  class Client
    attr_accessor :connection

    include Adapters::NetHttpAdapter

    def proxy_for interface
      Proxy.new self, interface
    end
    
    def proxy
      proxy_for nil
    end

    def initialize configuration = {}
      @connection = init_connection(configuration)
    end

    def init_connection configuration = {}
      Connection.build configuration
    end

    def call name, *args
      execute Request.new(name, *args)
    end

    def call_to_ruby name, *args
      call(name, *args).to_ruby
    end

    def execute_to_ruby request
      execute(request).to_ruby
    end

    def execute request
      xml = request.to_xml_rpc
      
      Response.new send_method_call(xml)
    end
  end
end