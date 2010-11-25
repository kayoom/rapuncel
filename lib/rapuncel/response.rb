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
        @to_ruby = nil
        @status = http_response.code
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
      
      @to_ruby = Fault.from_xml_rpc fault.first
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
      
      @to_ruby = values.to_a.map do |node|
        Object.from_xml_rpc node
      end
    end
  end
end
