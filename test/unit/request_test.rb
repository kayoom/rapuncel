require 'test_helper'
require 'ruby-debug'

class RequestTest < ActiveSupport::TestCase
  test "Serialized request should have 1 methodCall tag" do
    request = Rapuncel::Request.new 'test_method', "one argument", "another"
    
    xml = request.to_xml_rpc
    assert_select xml, '/methodCall', 1
  end
end