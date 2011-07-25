require 'rapuncel/adapters/net_http_adapter'
require 'rapuncel/connection'
require 'rapuncel/xml_rpc/serializer'
require 'rapuncel/xml_rpc/deserializer'
require 'active_support/core_ext/hash/except'
require 'active_support/inflector/methods'

module Rapuncel
  class Client
    attr_accessor :connection, :raise_on_fault, :raise_on_error

    include Adapters::NetHttpAdapter

    def proxy_for interface
      Proxy.new self, interface
    end

    def proxy
      proxy_for nil
    end

    def initialize configuration = {}
      @connection = Connection.new configuration.except(:raise_on, :serialization)
      @serialization = configuration[:serialization]
      
      @raise_on_fault, @raise_on_error = case configuration[:raise_on]
      when :fault
        [true, false]
      when :error
        [false, true]
      when :both
        [true, true]
      else
        [false, false]
      end
    end

    # Dispatch a method call and return the response as Rapuncel::Response object.
    def call name, *args
      execute Request.new(name, *args)
    end

    # Dispatch a method call and return the response as parsed ruby.
    def call_to_ruby name, *args
      response = call name, *args

      raise_on_fault && response.fault? && raise_fault(response)
      raise_on_error && response.error? && raise_error(response)

      response.to_ruby
    end

    protected
    def execute request
      xml = serializer[request]

      Response.new send_method_call(xml), deserializer
    end
    
    def serialization
      case @serialization
      when Module
        @serialization
      when String, Symbol
        ActiveSupport::Inflector.constantize(@serialization.to_s)
      else
        XmlRpc
      end
    end
    
    def serializer
      @serializer ||= serialization.const_get 'Serializer'
    end
    
    def deserializer
      @deserializer ||= serialization.const_get 'Deserializer'
    end
    
    private
    def raise_fault response
      raise(Response::Fault, response.fault[:faultCode], response.fault[:faultString].split("\n"))
    end
    
    def raise_error response
      raise(Response::Error, "HTTP Error: #{response.error.inspect}")
    end
  end
end