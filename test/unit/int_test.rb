require 'test_helper'

class IntTest < ActiveSupport::TestCase
  
  test "should convert the number 1234567 to the string '<int>1234567</int>'" do
    assert_equal "<int>1234567</int>", 1234567.to_xml_rpc
  end
  
  test "should warn if numbers go out of 4 byte signed integer range [#{(-2**31).to_s}, #{(2**31-1)}], e.g #{(2**31).to_s}, but should still give the right result as long as ruby can handle the number" do
    assert_equal "<int>#{(2**31).to_s}</int>", (2**31).to_xml_rpc
  end
  
  
  
end