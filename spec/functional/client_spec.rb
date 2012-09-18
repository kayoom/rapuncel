require 'spec_helper'

describe Rapuncel::Client do
  it 'simple XMLRPC' do
    client = Rapuncel::Client.new :port => 9485
    proxy = client.proxy_for 'num'

    proxy.add(40, 2).should == 42
  end

  it 'fault XMLRPC without raising' do
    client = Rapuncel::Client.new :port => 9485
    proxy = client.proxy_for 'num'

    lambda do
      proxy.add 20, 20, 2
    end.should_not raise_error Rapuncel::Response::Exception


    proxy.add(20, 20, 2).should be_a Hash
  end

  it 'fault XMLRPC with raising' do
    client = Rapuncel::Client.new :port => 9485, :raise_on => :both
    proxy = client.proxy_for 'num'

    lambda do
      proxy.add 20, 20, 2
    end.should raise_error Rapuncel::Response::Fault
  end

  it 'error in connection without raising' do
    client = Rapuncel::Client.new :port => 9486, :path => '/somefoobarurl'
    proxy = client.proxy

    lambda do
      proxy.foo :bar, :baz
    end.should_not raise_error Rapuncel::Response::Error

    err = proxy.foo(:bar, :baz)
    err.should be_a Hash
  end

  it 'error in connection with raising' do
    client = Rapuncel::Client.new :port => 9486, :path => '/somefoobarurl', :raise_on => :both
    proxy = client.proxy

    lambda do
      proxy.foo :bar
    end.should raise_error Rapuncel::Response::Error
  end
end
