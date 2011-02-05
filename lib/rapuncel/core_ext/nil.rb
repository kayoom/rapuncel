class NilClass
  def to_xml_rpc b = Rapuncel.get_builder
    false.to_xml_rpc b

    b.to_xml
  end
end