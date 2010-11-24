require 'builder'


class TrueClass
  
  def to_xml_rpc b=Rapuncel.get_builder
    b.boolean "1"
  end
  
  
end


class FalseClass
  
  def to_xml_rpc b=Rapuncel.get_builder
    b.boolean "0"
  end
end
