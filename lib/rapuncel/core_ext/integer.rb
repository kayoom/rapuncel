class Integer
  def to_xml_rpc builder = Rapuncel.get_builder
    builder.int to_s

    builder.to_xml
  end

  def self.from_xml_rpc xml_node
    xml_node.text.strip.to_i #calling to_i on the text between the i4 or int tags
  end
end
