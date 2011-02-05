class String
  def to_xml_rpc b = Rapuncel.get_builder
    b.string self

    b.to_xml
  end

  def self.from_xml_rpc xml_node
    xml_node.text.gsub(/(\r\n|\r)/, "\n") #just give back the string between the 'string' tags
    # DISCUSS: to strip or not to strip
  end
end
