class TrueClass
  def to_xml_rpc b = Rapuncel.get_builder
    b.boolean "1"

    b.to_xml
  end
end

class FalseClass
  def to_xml_rpc b = Rapuncel.get_builder
    b.boolean "0"

    b.to_xml
  end
end

# this is to catch the from_xml_rpc call from Object
class Rapuncel::Boolean
  def self.from_xml_rpc xml_node

    # DISCUSS: need convention here:
    case xml_node.text.downcase
    when '1'
      true
    else
      false
    end
  end
end
