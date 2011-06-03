require 'spec_helper'

describe Float do
  describe "Serialization" do
    it "can serialize Floats" do
      number = 1.23456
      
      number.to_xml_rpc.should have_xpath('/double', :content => "1.23456")
    end
    
    it "can serialize BigDecimal" do
      number = BigDecimal.new '1.23456'
      number.to_xml_rpc.should have_xpath('/double', :content => "1.23456")
    end
  end
  
  describe "Deserialization" do
    it "can deserialize double" do
      xml = <<-XML
        <double>1.23456</double>
      XML
      
      Object.from_xml_rpc(xml).should be_a Float
      Object.from_xml_rpc(xml).should == 1.23456
    end
    
    it "can optionally deserialize all double to BigDecimal" do
      Float.xmlrpc_double_as_bigdecimal = true
      
      xml = <<-XML
        <double>1.23456</double>
      XML
      
      Object.from_xml_rpc(xml).should be_a BigDecimal
      Object.from_xml_rpc(xml).to_s("F").should == "1.23456"
    end
  end
end