class NilClass
  def to_xml_rpc builder = Rapuncel.get_builder
    false.to_xml_rpc builder

    builder.to_xml
  end
end