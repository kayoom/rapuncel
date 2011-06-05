require 'net/http'
require 'net/https'

module Rapuncel
  module Adapters
    module NetHttpAdapter
      # Small response wrapper
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

      # Dispatch a XMLRPC via HTTP and return a response object.
      def send_method_call str
        request = Net::HTTP.new connection.host, connection.port
        request.use_ssl = connection.ssl?
        request.basic_auth connection.user, connection.password if connection.auth?

        HttpResponse.new request.post(connection.path, str, connection.headers)
      end
    end
  end
end