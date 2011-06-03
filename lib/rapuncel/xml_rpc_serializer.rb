require 'bigdecimal'
require 'time'

module Rapuncel
  class XmlRpcSerializer
    XML_ENCODING = 'UTF-8'
    
    attr_reader :builder
    
    def initialize object
      @builder = Nokogiri::XML::Builder.new :encoding => XML_ENCODING
      
      serialize object
    end
    
    def serialize object
      case object
      when Array
        serialize_array object
      when String, Symbol
        serialize_string object.to_s
      when TrueClass
        serialize_true
      when FalseClass
        serialize_false
      when Float
        serialize_float object
      when BigDecimal
        serialize_big_decimal object
      when Hash
        serialize_hash object
      when Integer
        serialize_integer object
      when NilClass
        serialize_nil
      when Time
        serialize_time object
      when Request
        serialize_request object
      else
        if object.respond_to?(:acts_like?) && object.acts_like?(:time)
          serialize_time object
        else
          serialize_hash instance_variable_hash(object)
        end
      end
      
      self
    end
    
    def serialize_array array
      builder.array do |builder|
        builder.data do |builder|
          array.each do |element|
            builder.value do |_|
              serialize element
            end
          end
        end
      end
    end
    
    def serialize_string string
      builder.string string
    end
    
    def serialize_true
      builder.boolean "1"
    end
    
    def serialize_false
      builder.boolean "0"
    end
    alias_method :serialize_nil, :serialize_false
    
    def serialize_float float
      builder.double float.to_s
    end
    
    def serialize_big_decimal big_decimal
      builder.double big_decimal.to_s("F")
    end
    
    def serialize_hash hash
      builder.struct do |builder|
        hash.each_pair do |key, value|
          builder.member do |builder|
            # Get a better string representation of BigDecimals
            key = key.to_s("F") if BigDecimal === key
            builder.name key.to_s

            builder.value do |builder|
              serialize value
            end
          end
        end
      end
    end
    
    def serialize_integer int
      builder.int int.to_s
    end
    
    def serialize_time time
      builder.send "dateTime.iso8601", time.iso8601
    end
    
    def serialize_request request
      builder.methodCall do |builder|
        builder.methodName request.method_name
        builder.params do |builder|
          request.arguments.each do |argument|
            builder.param do |builder|
              builder.value do |builder|
                serialize argument
              end
            end
          end
        end
      end
    end
    
    def to_xml
      @builder.to_xml
    end
    
    protected
    def instance_variable_hash object
      {}.tap do |hash|
        object.instance_variables.each do |ivar|
          hash[ivar[1..-1]] = object.instance_variable_get ivar
        end
      end
    end
    
    class << self
      def [] object
        new(object).to_xml
      end
    end
  end
end