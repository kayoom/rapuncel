require 'builder'


module Rapuncel
  class Request
    attr_accessor :method_name, :arguments


    # Create a new XML-RPC request
    def initialize method_name, *args
      @method_name, @arguments = method_name, args
    end

    def to_xml_rpc builder = Rapuncel.get_builder
      method_call! builder
    end

    protected
    def method_call! builder
      builder.instruct!

      builder.methodCall do
        method_name! builder
        params! builder
      end
    end

    def method_name! builder
      builder.methodName method_name
    end

    def params! builder
      builder.params do
        arguments.each do |value|
          param! builder, value
        end
      end
    end

    def param! builder, value
      builder.param do
        builder.value do
          value.to_xml_rpc builder
        end
      end
    end
  end
end
