require 'builder'
require 'nokogiri'
require 'ruby-debug'

class Integer

  def to_xml_rpc b = Rapuncel.get_builder
    warn "XML-RPC standard only supports 4 byte signed integers, i.e #{(-2**31).to_s} to #{2**31-1}" unless ((-2**31)...(2**31)) === self

    b.int self.to_s

  end

  def self.from_xml_rpc xml_node
    warn "xml node given (name of #{xml_node.name}) is not of integer type, node name should be 'i4' or 'int'" unless ['i4','int'].include? xml_node.name.downcase

    xml_node.text.to_i #calling to_i on the text between the i4 or int tags
  end
end
