require 'test_helper'

class NilTest < ActiveSupport::TestCase
  
  test "nil should have the same response as false" do
    assert_equal false.to_xml_rpc, nil.to_xml_rpc
  end
  
  test "nil must evaluate to /boolean/0, as does false" do
    assert_select nil.to_xml_rpc, '/boolean', 1
    assert_select nil.to_xml_rpc, '/boolean', '0'
  end
  
  
  
end