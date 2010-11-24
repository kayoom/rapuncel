require 'builder'

class Float
  
  protected
  
  def to_xml_rpc_name #we can just change this function. see why in object.rb
    "double"
  end
  
  
  def from_xml_rpc xml_node
    warn "Node given (name of #{xml_node.name}) is not a 'double' node, name should be 'double'. Will still parse, at your risk." unless 
    
    
  end
end
