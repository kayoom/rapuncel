require 'functional_test_helper'

class ClientTest < FunctionalTest
  test "Simple XMLRPC call" do
    client = Rapuncel::Client.new :port => 8080
    proxy = client.proxy_for 'num'
    
    result = proxy.add 40, 2
    
    assert_kind_of Array, result
    assert_equal 42, result.first
  end
  
  test "Fault rpc call" do
    client = Rapuncel::Client.new :port => 8080
    proxy = client.proxy_for 'num'
    
    result = proxy.add 23, 23, 23
    
    assert_kind_of Rapuncel::Fault, result
  end
  
  test 'RPC call to wrong host' do
    
  end
end