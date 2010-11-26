require 'typhoeus'
require 'active_support/memoizable'

module Rapuncel
  module Adapters
    module TyphoeusAdapter
      extend ActiveSupport::Memoizable
      
      
      def send_method_call str
        Typhoeus::Request.post connection.url, typhoeus_params.merge(:body => str)
      end

      protected
      def typhoeus_params
        {
          :headers => connection.headers
        }.merge auth_params
      end
      memoize :typhoeus_params

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