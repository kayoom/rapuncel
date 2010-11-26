require 'test_helper'


class StringTest < ActiveSupport::TestCase

  test "A string should simply be written between two <string></string> tags" do
    str = "blabla"
    xml = str.to_xml_rpc
    assert_select xml, '/string', 1
    assert_select xml, '/string', str
  end
  
  test "A string to_xml_rpc from_xml_rpc should be itself, even with whitespace" do #weird characters too?? or do we need base64 for that
    str = "yabba dabba doo!   \t"
    xml = str.to_xml_rpc
    
    
    xml_node = Nokogiri::XML(xml).children.first
    
    assert_equal str, String.from_xml_rpc(xml_node)
  end
    
end
