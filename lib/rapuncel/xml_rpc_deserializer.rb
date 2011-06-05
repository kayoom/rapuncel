module Rapuncel
  class XmlRpcDeserializer
    XML_ENCODING = 'UTF-8'
    
    def initialize xml
      @xml_doc = Nokogiri::XML.parse xml
    end
    
    def deserialize xml_node = root_node
      send "deserialize_#{xml_node.name}", xml_node
    end
    
    def deserialize_base64 xml_node
      Base64String.decode_base64 xml_node.text.strip
    end
    
    def deserialize_string xml_node
      xml_node.text.gsub(/(\r\n|\r)/, "\n")
    end
    
    def deserialize_array xml_node
      values = xml_node.first_element_child.element_children

      values.map do |value|
        deserialize value.first_element_child
      end
    end
    
    def deserialize_boolean xml_node
      xml_node.text == "1"
    end
    
    def deserialize_double xml_node
      text = xml_node.text.strip
      
      if double_as_bigdecimal?
        BigDecimal.new text
      else
        text.to_f
      end
    end
    
    def deserialize_struct xml_node
      keys_and_values = xml_node.element_children

      {}.tap do |hash|
        keys_and_values.each do |key_value|
          key = key_value.first_element_child.text.strip
          key = key.to_sym unless hash_keys_as_string?
          
          value = deserialize key_value.last_element_child.first_element_child

          hash[key] = value
        end
      end      
    end
    
    def deserialize_int xml_node
      xml_node.text.strip.to_i
    end
    alias_method :deserialize_i4, :deserialize_int
    
    define_method "deserialize_dateTime.iso8601" do |xml_node|
      Time.parse xml_node.text.strip
    end
    
    def deserialize_methodResponse xml_node
      response = xml_node.first_element_child
      
      if response.name == 'fault'
        deserialize_methodResponse_fault response
      else
        deserialize_methodResponse_params response
      end
    end
    
    def deserialize_methodResponse_params xml_node
      deserialize xml_node.first_element_child.first_element_child.first_element_child
    end
    
    def deserialize_methodResponse_fault xml_node
      deserialize xml_node.first_element_child.first_element_child
    end
    
    def to_ruby
      deserialize
    end
    
    protected
    def root_node
      @xml_doc.root
    end
    
    def double_as_bigdecimal?
      !!self.class.double_as_bigdecimal
    end
    
    def hash_keys_as_string?
      !!self.class.hash_keys_as_string
    end
    
    class << self
      attr_accessor :double_as_bigdecimal, :hash_keys_as_string
      
      def [] xml
        new(xml).to_ruby
      end
    end
  end
end