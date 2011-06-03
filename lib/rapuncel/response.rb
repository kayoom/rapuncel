require 'active_support/core_ext/module/delegation'
require 'rapuncel/xml_rpc_deserializer'

module Rapuncel
  class Response
    class Exception < ::Exception ; end
    class Fault < Exception ; end
    class Error < Exception ; end

    attr_accessor :http_response, :status, :status_code, :response

    delegate  :body,
              :to => :http_response

    def initialize http_response
      @http_response = http_response

      evaluate_status
    end

    def evaluate_status
      @status_code = http_response.code.to_i

      @status = unless http_response.success?
        'error'
      else
        deserialize_response
        
        if Hash === response && response[:faultCode]
          'fault'
        else
          'success'
        end
      end
    end

    def success?
      status == 'success'
    end

    def fault?
      status == 'fault'
    end

    def error?
      status == 'error'
    end

    def fault
      fault? && @response
    end

    def error
      error? && { :http_code => @status_code, :http_body => body }
    end

    def result
      success? && @response
    end

    def to_ruby
      result || fault || error
    end

    protected
    def deserialize_response
      @response = XmlRpcDeserializer.new(body).to_ruby
    end
  end
end
