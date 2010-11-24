require 'typhoeus'

module Rapuncel
  module Adapters
    module TyphoeusAdapter
      def send_body str
        Typhoeus::Request.post connection.url, typhoeus_params.merge(:body => str)
      end

      protected
      def typhoeus_params
        {
          :headers => connection.headers
        }.merge auth_params
      end

      def auth_params
        return {} unless connection.http_auth?

        {
          :user         => connection.user,
          :password     => connection.password,
          :auth_method  => connection.auth_method
        }
      end
    end
  end
end