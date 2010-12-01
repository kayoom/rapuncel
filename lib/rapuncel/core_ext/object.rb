

class Object
  def to_xml_rpc b = Rapuncel.get_builder
    if respond_to?(:acts_like?) && acts_like?(:time)
      to_time.to_xml_rpc b
    else    
      _collect_ivars_in_hash.to_xml_rpc b
    end
    
    b.to_xml
  end

  def self.from_xml_rpc xml_node
    if xml_node.is_a? String
      xml_node = Nokogiri::XML.parse(xml_node).root
    end
    
    return nil if xml_node.nil?
    
    case xml_node.name
    when 'i4', 'int'
      Integer.from_xml_rpc xml_node
    when 'array'
      Array.from_xml_rpc xml_node
    when 'struct'
      Hash.from_xml_rpc xml_node
    when 'double'
      Float.from_xml_rpc xml_node
    when 'boolean'
      Rapuncel::Boolean.from_xml_rpc xml_node
    when 'string'
      String.from_xml_rpc xml_node
    when 'dateTime.iso8601'
      Time.from_xml_rpc xml_node
    when 'base64'
      raise 'Now its time to implement Base64'
    else
      raise "What is this? I didn't know #{xml_node.name} was part of the XMLRPC specification? Anyway, the value was: #{xml_node.text}"
    end
  end

  private
  def _collect_ivars_in_hash
    {}.tap do |hsh|
      instance_variables.each do |ivar|
        hsh[ivar[1..-1]] = instance_variable_get ivar
      end
    end
  end
end
