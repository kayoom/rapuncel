require 'builder'
require 'nokogiri'

class Float
  def self.from_xml_rpc xml_node
    warn "Node given (name of #{xml_node.name}) is not a 'double' node, name should be 'double'. Will still parse, at your risk." unless ['double'].include? xml_node.name.downcase
    
    xml_node.text.to_f #calling to_float on the text between the (hopefully correct) tags
    
    
  end

  protected
  def to_xml_rpc_name #we can just change this function. see why in object.rb
    "double"
  end
  
  
end
