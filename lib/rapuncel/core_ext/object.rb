require 'builder'

class Object

  def to_xml_rpc b = Rapuncel.get_builder
    b.tag! to_xml_rpc_name.to_sym, to_s
  end

  def self.from_xml_rpc xml_node
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
      Boolean.from_xml_rpc xml_node
    when 'string'
      String.from_xml_rpc xml_node
    when 'dateTime.iso8601'
      Time.from_xml_rpc xml_node
    else

    end
  end

  protected
  def to_xml_rpc_name
    warn "No specific to_xml_rpc_name method written for this object (#{self.class.to_s}). The result may not be what you expect."
    self.class.to_s.downcase
  end
end
