require 'functional_test_helper'

class FunctionalClientTest < FunctionalTest
  test "Simple XMLRPC call" do
    client = Rapuncel::Client.new :port => 8080
    proxy = client.proxy_for 'num'
    
    result = proxy.add 40, 2
    
    assert_equal 42, result
  end
  
  test "Fault rpc call" do
    client = Rapuncel::Client.new :port => 8080
    proxy = client.proxy_for 'num'
    
    result = proxy.add 20, 20, 2
    
    assert_kind_of Rapuncel::Fault, result
  end
  

end