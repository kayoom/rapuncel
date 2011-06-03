require 'bigdecimal'

class BigDecimal
  def to_xml_rpc b = Rapuncel.get_builder
    b.double self.to_s("F")

    b.to_xml
  end
  
  def self.from_xml_rpc xml_node
    new xml_node.text.strip
  end
end