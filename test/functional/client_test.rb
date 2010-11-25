require 'functional_test_helper'

class ClientTest < FunctionalTest
  test "Simple XMLRPC call" do
    client = Rapuncel::Client.new :port => 8080
    proxy = client.proxy_for 'num'
    
    result = proxy.add 40, 2
    
    assert_equal 42, result
  end
  
  test "Fault rpc call" do
    client = Rapuncel::Client.new :port => 8080
    proxy = client.proxy_for 'num'
    
    result = proxy.add 23, 23, 23
    
    assert_kind_of Rapuncel::Fault, result
  end
end