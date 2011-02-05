


module Rapuncel
  class Request
    attr_accessor :method_name, :arguments


    # Create a new XML-RPC request
    def initialize method_name, *args
      @method_name, @arguments = method_name, args
    end

    def to_xml_rpc builder = Rapuncel.get_builder
      method_call! builder

      builder.to_xml :encoding => 'UTF-8'
    end

    protected
    def method_call! builder

      builder.methodCall do |builder|
        method_name! builder
        params! builder
      end
    end

    def method_name! builder
      builder.methodName method_name
    end

    def params! builder
      builder.params do |builder|
        arguments.each do |value|
          param! builder, value
        end
      end
    end

    def param! builder, value
      builder.param do |builder|
        builder.value do |builder|
          value.to_xml_rpc builder
        end
      end
    end
  end
end
