
require 'time'
require 'nokogiri'

class Time

  def to_xml_rpc b=Rapuncel.get_builder
    b.send "dateTime.iso8601", self.iso8601
    
    b.to_xml
  end
  
  def self.from_xml_rpc xml_node
    #warn "Need node to be named 'dateTime.iso8601', but it is #{xml_node.name}. Will still parse, at your risk" unless ['dateTime.iso8601'].include? xml_node.name
    
    Time.parse xml_node.text #make a Time object of this string which is hopefully in the right format
  end
    
end
