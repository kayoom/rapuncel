require 'rapuncel/xml_rpc_serializer'

module Rapuncel
  class Request
    attr_accessor :method_name, :arguments

    # Create a new XML-RPC request
    def initialize method_name, *args
      @method_name, @arguments = method_name, args
    end
  end
end
