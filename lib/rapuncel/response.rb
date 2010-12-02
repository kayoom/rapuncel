require 'active_support/core_ext/module/delegation'
require 'rapuncel/fault'

module Rapuncel
  class Response
    class Exception < ::Exception
      attr_accessor :code, :string
      
      def initialize code, string
        @code, @string = code, string
      end
      
      def exception
        self
      end
    end
    class Fault < Exception ; end
    class Error < Exception ; end
    
    attr_accessor :http_response, :status, :status_code

    delegate  :body,
              :to => :http_response

    def initialize http_response
      @http_response = http_response
      
      evaluate_status
    end
    
    def evaluate_status
      @status_code = http_response.code.to_i
      
      @status = case
      when !http_response.success?                  then 'error'
      when parsed_body && method_response_success?  then 'success'
      else 'fault'
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
      if fault?
        @fault ||= begin
          fault_node = parsed_body.xpath('/methodResponse/fault/value/struct').first
          fault_hash = Hash.from_xml_rpc(fault_node)
          
          Fault.new fault_hash[:faultCode], fault_hash[:faultString]
        end
      end
    end
    
    def error
      if error?
        @error ||= Error.new @status_code, body
      end
    end    
    
    def result
      if success?
        @result ||= begin
          return_values = parsed_body.xpath('/methodResponse/params/param/value/*')
          
          Object.from_xml_rpc return_values.first
        end
      end
    end

    def to_ruby
      result || fault || error
    end
    
    protected
    def parsed_body
      @xml_doc ||= Nokogiri::XML.parse body
    end    
    
    def method_response_success?
      parsed_body.xpath('/methodResponse/fault').empty?
    end
  end
end
