module Rapuncel
  module Adapters
    module TyphoeusAdapter
      # class TyphoeusConnection < Connection
      #   
      # end
      

      
      def send_body str
        Typhoeus::Request.post connection.url, typhoeus_params.merge(:body => str)
      end
      
      def typhoeus_params
        # {
        #   :met
        # }
      end
    end
  end
end