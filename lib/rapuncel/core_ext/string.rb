class String
  def to_xml_rpc builder = Rapuncel.get_builder
    builder.string self

    builder.to_xml
  end

  def self.from_xml_rpc xml_node
    xml_node.text.gsub(/(\r\n|\r)/, "\n")
  end
end
