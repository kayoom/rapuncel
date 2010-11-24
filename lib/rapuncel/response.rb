require 'active_support/core_ext/module/delegation'

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
        else
          @status = 'fault'
          #TODO handle faults
        end
      else
        #TODO handle 404, 403 etc
        @status = 'error'
      end
    end
    
    def success?
      status == 'success'
    end
    
    def to_ruby
      body
    end
  end
end