class Symbol
  def to_xml_rpc builder = Rapuncel.get_builder
    builder.string to_s

    builder.to_xml
  end
end
