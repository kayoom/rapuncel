require 'spec_helper'

describe Rapuncel::Proxy do
  before do
    @client = mock "Rapuncel::Client"
    @proxy =  Rapuncel::Proxy.new @client
  end
  
  it "provides unproxied __ methods" do
    @client.should_not_receive :call_to_ruby

    @proxy.__inspect__
    @proxy.__tap__ {}
    @proxy.__freeze__
    @proxy.__send__ :__inspect__
  end
  
  it 'proxies inspect, freeze, tap' do
    %w(inspect freeze tap).each do |method|
      @client.should_receive(:call_to_ruby).with(method)
      @proxy.__send__ method
    end
  end
  
  it 'proxies any method call' do
    @client.should_receive(:call_to_ruby).with("abcd", 1, "foo")
    @proxy.abcd 1, "foo"
  end
end
