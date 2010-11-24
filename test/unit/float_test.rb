require 'test_helper'

class FloatTest < ActiveSupport::TestCase
  test "A float should be a number between 'double' tags" do
    num=1.123456
    xml=num.to_xml_rpc
    
    assert_select xml, '/double', 1
    assert_select xml, '/double', num.to_s
    
  end
  
  test "A float converted to xml and back should be the same number!" do
    num=1.123456
    xml=num.to_xml_rpc
    
    xml_node=Nokogiri::XML(xml).children.first #make a nokogiri xml_node containing the float
    
    assert_equal num, Float.from_xml_rpc(xml_node)
  end
    
    
end