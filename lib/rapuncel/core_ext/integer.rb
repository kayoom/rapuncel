require 'builder'

class Integer
  
  def to_xml_rpc b=Rapuncel.get_builder
    warn "XML-RPC standard only supports 4 byte signed integers, i.e #{(-2**31).to_s} to #{2**31-1}" unless ((-2**31)...(2**31)) === self
    
    b.int self.to_s
    
  end
  
end