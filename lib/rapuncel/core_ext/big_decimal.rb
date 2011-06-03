require 'bigdecimal'

class BigDecimal
  def to_xml_rpc builder = Rapuncel.get_builder
    builder.double self.to_s("F")

    builder.to_xml
  end
  
  def self.from_xml_rpc xml_node
    new xml_node.text.strip
  end
end