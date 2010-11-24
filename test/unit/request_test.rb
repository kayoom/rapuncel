require 'test_helper'

class RequestTest < ActiveSupport::TestCase
  def get_test_request
    Rapuncel::Request.new 'test_method', "one argument", "another"
  end

  test "Serialized request shuold have xml version=1.0" do
    xml = get_test_request.to_xml_rpc

    assert xml.match(/<\?xml version=['"]1.0/)
  end

  test "Serialized request should have 1 methodCall tag" do
    xml = get_test_request.to_xml_rpc
    assert_select xml, '/methodCall', 1
  end

  test "Serialized request should contain methodName" do
    xml = get_test_request.to_xml_rpc

    assert_select xml, '/methodCall/methodName', 'test_method'
  end

  test "Serialized request should contain params" do
    xml = get_test_request.to_xml_rpc

    assert_select xml, '/methodCall/params', 1
    assert_select xml, '/methodCall/params/param/value', 2

    assert_select xml, '/methodCall/params/param/value', 'one argument', 1
    assert_select xml, '/methodCall/params/param/value', 'another', 1
  end
end
