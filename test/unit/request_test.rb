require 'test_helper'
require 'ruby-debug'

class RequestTest < ActiveSupport::TestCase
  def get_test_request
    Rapuncel::Request.new 'test_method', "one argument", "another"
  end
  
  test "Serialized request should have 1 methodCall tag" do
    xml = get_test_request.to_xml_rpc
    assert_select xml, '/methodCall', 1
  end
  
  test "Serialized request should contain methodName" do
    xml = get_test_request.to_xml_rpc
    
    assert_select xml, '/methodCall/methodName', 'test_method'
  end
end