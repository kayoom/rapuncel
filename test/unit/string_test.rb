require 'test_helper'


class StringTest < ActiveSupport::TestCase
  
  test "A string should simply be written between two <string></string> tags" do
    str="blabla"
    xml=str.to_xml_rpc
    assert_select xml, '/string', 1
    assert_select xml, '/string', str
  end
end
