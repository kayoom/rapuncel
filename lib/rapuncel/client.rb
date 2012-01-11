require 'rapuncel/adapters/curb_adapter'
require 'rapuncel/connection'
require 'rapuncel/xml_rpc/serializer'
require 'rapuncel/xml_rpc/deserializer'
require 'active_support/core_ext/hash/except'
require 'active_support/inflector/methods'
require 'active_support/deprecation'

module Rapuncel
  class Client
    autoload :Logging, 'rapuncel/client/logging'
    
    attr_accessor :connection, :raise_on_fault, :raise_on_error

    include Adapters::CurbAdapter

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
      
      if logger = configuration[:logger]
        extend Logging
        initialize_logging logger, configuration[:log_level]
      end
    end

    def proxy_for interface = nil
      if interface.nil?
        @default_proxy ||= Proxy.new self, nil
      else
        @proxies ||= Hash.new do |hash, key|
          hash[key] = Proxy.new self, key
        end
        
        @proxies[interface.to_s]
      end
    end

    def proxy
      proxy_for nil
    end

    # Dispatch a method call and return the response as Rapuncel::Response object.
    def call name, *args
      ActiveSupport::Deprecation.warn "Using #call is deprecated, please use #call_to_ruby instead.", caller
      _call name, *args
    end

    # Dispatch a method call and return the response as parsed ruby.
    def call_to_ruby name, *args
      response = _call name, *args

      raise_on_fault && response.fault? && raise_fault(response)
      raise_on_error && response.error? && raise_error(response)

      response.to_ruby
    end

    protected
    def _call name, *args
      execute Request.new(name, *args)
    end
    
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
