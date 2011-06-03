class TrueClass
  def to_xml_rpc builder = Rapuncel.get_builder
    builder.boolean "1"

    builder.to_xml
  end
end

class FalseClass
  def to_xml_rpc builder = Rapuncel.get_builder
    builder.boolean "0"

    builder.to_xml
  end
end

class Rapuncel::Boolean
  def self.from_xml_rpc xml_node

    case xml_node.text.downcase
    when '1'
      true
    else
      false
    end
  end
end
