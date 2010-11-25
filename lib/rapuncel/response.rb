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
        @xml_doc = Nokogiri::XML.parse body

        if @xml_doc.xpath('/methodResponse/fault').blank?
          @status = 'success'
          parse_response
        else
          @status = 'fault'
          parse_fault
        end
      else
        @to_ruby = nil
        @status = 'error'
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
      
    end
  end
end
