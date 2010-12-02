class Float
  def self.from_xml_rpc xml_node
    xml_node.text.strip.to_f #calling to_float on the text between the (hopefully correct) tags
  end

  def to_xml_rpc b = Rapuncel.get_builder
    b.double to_s

    b.to_xml
  end
end
