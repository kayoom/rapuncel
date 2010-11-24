require 'builder'
require 'nokogiri'

class Array

  def to_xml_rpc b = Rapuncel.get_builder

    b.array do
      b.data do
        each do |array_entry|
          b.value do
            array_entry.to_xml_rpc b
          end
        end
      end
    end
  end
  
  
  def self.from_xml_rpc xml_node
    warn "Warning: This is not an array-node (It is a(n) #{xml_node.name}.). Parsing may go wrong. Continuing at your risk" unless ['array'].include? xml_node.name.downcase
    
    data_node=xml_node.children.first
    #child of xml_node should be a data tag
    warn "Warning: Child of array node is not a 'data' node, it is a #{data_node.name}. Continuing at your risk" unless ['data'].include? data_node.name.downcase
    
    values=data_node.children
    
    values.map do |value|
      warn "Value tag not present in child of child of array node. The tag is #{value.name}. Continuing at your risk" unless ['value'].include? value.name.downcase
      
      #the object is inside this value node
      obj=value.children.first
      #we parse it using object
      Object.from_xml_rpc obj
    end
    
    
  end
end
