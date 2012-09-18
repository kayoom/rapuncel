require 'curb'

module Rapuncel
  module Adapters
    module CurbAdapter
      # Small response wrapper
      class HttpResponse
        def initialize body, code
          @body, @code = body, code
        end

        def success?
          !(@code =~ /^2/)
        end

        def body
          @body
        end

        def code
          @code
        end
      end

      # Dispatch a XMLRPC via HTTP and return a response object.
      def send_method_call str
        @curb ||= Curl::Easy.new "#{connection.host}:#{connection.port}#{connection.path}"

        @curb.post_body = str
        @curb.headers = @curb.headers.merge connection.headers
        @curb.perform

        HttpResponse.new @curb.body_str, @curb.response_code
      end
    end
  end
end
