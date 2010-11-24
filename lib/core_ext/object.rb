require 'builder'

class Object
  
  def to_xml_rpc b=Rapuncel.get_builder
    warn "No specific to_xml_rpc method written for this object. The result may not be what you expect."
    
    b.tag! to_xml_rpc_name.to_sym, to_s
    
  end
  
  def to_xml_rpc_name
    self.class.to_s.downcase
  end
  
end