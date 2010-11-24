require 'test_helper'

class BooleanTest < ActiveSupport::TestCase

  test "true must evaluate to 1" do
    assert_select true.to_xml_rpc, '/boolean', 1
    assert_select true.to_xml_rpc, '/boolean', '1'
  end

  test "false must evaluate to 0" do
    assert_select false.to_xml_rpc, '/boolean', 1
    assert_select false.to_xml_rpc, '/boolean', '0'
  end
  
  test "true.to_xml_rpc reparsed must be true" do
    xml=true.to_xml_rpc
    xml_node = Nokogiri::XML(xml).children.first
    
    assert Boolean.from_xml_rpc(xml_node) #I assume assert takes a boolean?
    assert Boolean.from_xml_rpc(xml_node) == true #is this different? just in case the other function gives back something non nil/false which is not necessarily true
  end
  
  test "false.to_xml_rpc reparsed must be false" do
    xml=false.to_xml_rpc
    xml_node = Nokogiri::XML(xml).children.first
    
    assert !Boolean.from_xml_rpc(xml_node)
  end
  
  test "anything else should evaluate to what now?" do
    assert true
  end
  
end
