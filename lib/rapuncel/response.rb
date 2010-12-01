require 'active_support/core_ext/module/delegation'
require 'rapuncel/fault'

module Rapuncel
  class Response
    attr_accessor :http_response, :status

    delegate  :body,
              :to => :http_response

    def initialize http_response
      @http_response = http_response

      if http_response.success?
        parse_response
      else
        @status = http_response.code
        raise("HTTP Error: #{@status}\n#{body}")
      end
    end

    def success?
      status == 'success'
    end

    def to_ruby
      @to_ruby
    end
    
    def parse_fault
      fault = @xml_doc.xpath('/methodResponse/fault/value/struct')
      
      @to_ruby = Fault.new Hash.from_xml_rpc(fault.first)
      raise Fault, @to_ruby.code, @to_ruby.string.split("\n")
    end
    
    def parse_response
      @xml_doc = Nokogiri::XML.parse body

      if @xml_doc.xpath('/methodResponse/fault').blank?
        @status = 'success'
        parse_success
      else
        @status = 'fault'
        parse_fault
      end
    end
    
    def parse_success
      values = @xml_doc.xpath('/methodResponse/params/param/value/*')
      
      @to_ruby = Object.from_xml_rpc values.to_a.first
    end
  end
end
