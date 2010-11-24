require 'builder'
require 'nokogiri'

class String
  
  def self.from_xml_rpc xml_node
    warn "I, String.from_xml_rpc have been given an xml_node with the wrong tag (name of #{xml_node.name}). My tag should be 'string'. Will still parse at your risk" unless ['string'].include? xml_node.name.downcase
    
    xml_node.text #just give back the string between the 'string' tags
  end

  protected
  def to_xml_rpc_name #this suffices. go to object.rb to see why
    "string"
  end
end
