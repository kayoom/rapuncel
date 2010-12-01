require 'builder'
require 'nokogiri'

class NilClass
  
  def to_xml_rpc
    false.to_xml_rpc
  end
  
  
end