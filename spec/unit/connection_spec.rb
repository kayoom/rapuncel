require 'spec_helper'

describe Rapuncel::Connection do
  it 'can use the host option with or without an extra "http://"' do
    connection = Rapuncel::Connection.build :host => "http://example.org"
    
    connection.host.should == "example.org"
  end
  
  it 'can use the path option with or without leading "/"' do
    connection = Rapuncel::Connection.build :host => "http://example.org", :path => "abcd"
    
    connection.path.should == "/abcd"
  end
end

