require 'spec_helper'

describe Integer do
  it "serialization" do
    Rapuncel::XmlRpcSerializer[123].should have_xpath('/int', :content => "123")
  end
  
  it "deserialization of int" do
    xml = <<-XML
      <int>123</int>
    XML
    
    Rapuncel::XmlRpcDeserializer[xml].should == 123
  end
  
  it 'deserialization of i4' do
    xml = <<-XML
      <i4>123</i4>
    XML
    
    Rapuncel::XmlRpcDeserializer[xml].should == 123
  end
end
