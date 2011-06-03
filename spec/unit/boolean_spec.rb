require 'spec_helper'

describe TrueClass, FalseClass do
  describe "Serialization" do
    it 'represents true as 1' do
      true.to_xml_rpc.should have_xpath('/boolean', :content => '1')
    end
    
    it 'represents false as 0' do
      false.to_xml_rpc.should have_xpath('/boolean', :content => '0')
    end
  end
  
  describe "Deserialization" do
    it 'reads 1 as true' do
      xml = <<-XML
        <boolean>1</boolean>
      XML
      
      Object.from_xml_rpc(xml).should be_a TrueClass
    end
    
    it 'reads 0 as false' do
      xml = <<-XML
        <boolean>0</boolean>
      XML
      
      Object.from_xml_rpc(xml).should be_a FalseClass
    end
    
    it 'reads anything else as false' do
      xml = <<-XML
        <boolean>abcd</boolean>
      XML
      
      Object.from_xml_rpc(xml).should be_a FalseClass
    end
  end
end