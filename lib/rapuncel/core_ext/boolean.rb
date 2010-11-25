require 'builder'
require 'nokogiri'

class TrueClass

  def to_xml_rpc b = Rapuncel.get_builder
    b.boolean "1"
  end
end


class FalseClass

  def to_xml_rpc b = Rapuncel.get_builder
    b.boolean "0"
  end
end


class Rapuncel::Boolean #this is to catch the from_xml_rpc call from Object
  def self.from_xml_rpc xml_node
    warn "This node is not boolean (it is #{xml_node.name}), but will be treated as one at your request. keep in mind that 1 means true and all the rest will be false" unless ['boolean'].include? xml_node.name.downcase
    
    #need convention here:
    case xml_node.text.downcase
    when '1'
      true
    else
      false
    end    
  end  
end
