require 'test_helper'

class IntTest < ActiveSupport::TestCase
  
  def test_number num = 1    
    assert_select num.to_xml_rpc, '/int', 1
    assert_select num.to_xml_rpc, '/int', num.to_s
  end
  
  test "should warn if numbers go out of 4 byte signed integer range [#{(-2**31).to_s}, #{(2**31-1)}], e.g #{(2**31).to_s}, 
        but should still give the right result as long as ruby can handle the number" do
    #assert_equal "<int>#{(2**31).to_s}</int>", (2**31).to_xml_rpc
    num = 2**31
    test_number num
  end
end