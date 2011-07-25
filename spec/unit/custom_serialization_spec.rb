require 'spec_helper'

describe "Custom serialization" do
  module CustomSerialization
    class Serializer < Rapuncel::XmlRpc::Serializer
    end
    
    class Deserializer < Rapuncel::XmlRpc::Deserializer
    end
  end
  
  it 'client selects custom (de)serializer, if provided by Symbol' do
    client = Rapuncel::Client.new :serialization => :CustomSerialization
    
    client.send(:serializer).should == CustomSerialization::Serializer
  end
  
  it 'client selects custom (de)serializer, if provided by Class' do
    client = Rapuncel::Client.new :serialization => CustomSerialization
    
    client.send(:serializer).should == CustomSerialization::Serializer
  end
end