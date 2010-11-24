require 'test_helper'

class BooleanTest < ActiveSupport::TestCase
  
  test "true must evaluate to 1" do
    assert_select true.to_xml_rpc, '/boolean', 1
    assert_select true.to_xml_rpc, '/boolean', '1'
  end
  
  test "false must evaluate to 0" do
    assert_select false.to_xml_rpc, '/boolean',1
    assert_select false.to_xml_rpc, '/boolean', '0'
  end
  
end
