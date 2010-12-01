
require 'nokogiri'

class String
  def to_xml_rpc b = Rapuncel.get_builder
    b.string self
    
    b.to_xml
  end
  
  def self.from_xml_rpc xml_node
    #warn "I, String.from_xml_rpc have been given an xml_node with the wrong tag (name of #{xml_node.name}). My tag should be 'string'. Will still parse at your risk" unless ['string'].include? xml_node.name.downcase
    
    xml_node.text #just give back the string between the 'string' tags
  end
end
