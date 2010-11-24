require 'builder'

class Object
  
  def to_xml_rpc b=Rapuncel.get_builder
    warn "Using Object.to_s"
    b.tag! to_xml_rpc_name.to_sym, to_s
    
  end
  
  protected
  def to_xml_rpc_name
    warn "No specific to_xml_rpc_name method written for this object. The result may not be what you expect."
    self.class.to_s.downcase
  end
  
end