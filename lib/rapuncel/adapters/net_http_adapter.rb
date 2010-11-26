require 'net/http'
require 'active_support/memoizable'

module Rapuncel
  module Adapters
    module NetHttpAdapter
      extend ActiveSupport::Memoizable
      
      class HttpResponse
        def initialize response
          @response = response
        end
        
        def success?
          @response.is_a? Net::HTTPOK
        end
        
        def body
          @response.body
        end
        
        def code
          @response.code
        end
      end
      
      def send_method_call str
        req = Net::HTTP.new connection.host, connection.port
        
        HttpResponse.new req.post(connection.path, str, connection.headers.stringify_keys)
      end
    end
  end
end