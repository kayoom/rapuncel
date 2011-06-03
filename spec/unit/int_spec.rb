require 'spec_helper'

describe Integer do
  it "serialization" do
    123.to_xml_rpc.should have_xpath('/int', :content => "123")
  end
  
  it "deserialization of int" do
    xml = <<-XML
      <int>123</int>
    XML
    
    Object.from_xml_rpc(xml).should == 123
  end
  
  it 'deserialization of i4' do
    xml = <<-XML
      <i4>123</i4>
    XML
    
    Object.from_xml_rpc(xml).should == 123
  end
end
