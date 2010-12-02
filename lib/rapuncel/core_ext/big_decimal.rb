class BigDecimal
  def to_xml_rpc b = Rapuncel.get_builder
    b.double self.to_s

    b.to_xml
  end
end