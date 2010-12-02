require 'functional_test_helper'

class FunctionalClientTest < FunctionalTest
  test "Simple XMLRPC call" do
    client = Rapuncel::Client.new :port => 8080, :raise_on => :both
    proxy = client.proxy_for 'num'

    result = proxy.add 40, 2

    assert_equal 42, result
  end
  
  test "Fault rpc call without raise" do
    client = Rapuncel::Client.new :port => 8080
    proxy = client.proxy_for 'num'
    
    assert_nothing_raised Rapuncel::Response::Exception do
      proxy.add 20, 20, 2
    end
    
    assert_kind_of Rapuncel::Response::Fault, proxy.add(20, 20, 2)    
  end

  test "Fault rpc call" do
    client = Rapuncel::Client.new :port => 8080, :raise_on => :both
    proxy = client.proxy_for 'num'
    
    assert_raise Rapuncel::Response::Fault do
      proxy.add 20, 20, 2
    end
  end
  
  test "Error rpc connection" do
    client = Rapuncel::Client.new :host => 'www.cice-online.net', :port => 80, :path => '/hullahoobahubbahooo', :raise_on => :both
    proxy = client.proxy
    
    assert_raise Rapuncel::Response::Error do
      proxy.foo :bar, :baz
    end
  end
  
  test "Error rpc connection without raise" do
    client = Rapuncel::Client.new :host => 'www.google.de', :port => 80, :path => '/hullahoobahubbahooo'
    proxy = client.proxy
    
    assert_nothing_raised Rapuncel::Response::Error do
      proxy.foo :bar, :baz
    end
    
    err = proxy.foo(:bar, :baz)
    assert_kind_of Rapuncel::Response::Error, err
    assert_equal 404, err.code
  end
end