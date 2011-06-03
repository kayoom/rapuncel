require 'spec_helper'

describe Object do
  class TestObject
    attr_accessor :a, :b, :c
  end
  
  describe "Serialization of an arbitrary Object" do
    it "serializes all instance variables like a hash" do
      obj = TestObject.new
      obj.a = "one"
      obj.b = "two"
      
      xml = obj.to_xml_rpc
      xml.should have_xpath('/struct/member', :count => 2)
      
      reparsed_object = Object.from_xml_rpc(xml)
      reparsed_object.should == {
        :a => 'one',
        :b => 'two'
      }
    end
  end
  
  describe "from_xml_rpc dispatching" do
    it 'int nodes should be dispatched to Integer' do
      xml = "<int>42</int>"

      Integer.should_receive :from_xml_rpc
      Object.from_xml_rpc xml
    end
    
    it "string nodes should be dispatched to String" do
      xml = "<string>foo<string>"

      String.should_receive :from_xml_rpc
      Object.from_xml_rpc xml
    end

    it "array nodes should be dispatched to Array" do
      xml = "<array>42</array>"

      Array.should_receive :from_xml_rpc
      Object.from_xml_rpc xml
    end

    it "struct nodes should be dispatched to Hash" do
      xml = "<struct>42</struct>"

      Hash.should_receive :from_xml_rpc
      Object.from_xml_rpc xml
    end

    it "boolean nodes should be dispatched to Rapuncel::Boolean" do
      xml = "<boolean>1</boolean>"

      Rapuncel::Boolean.should_receive :from_xml_rpc
      Object.from_xml_rpc xml
    end

    it "double nodes should be dispatched to Float" do
      xml = "<double>42.23</double>"

      Float.should_receive :from_xml_rpc
      Object.from_xml_rpc xml
    end

    it "dateTime.iso8601 nodes should be dispatched to Time" do
      xml = "<dateTime.iso8601>2010-11-25T11:44:46+01:00</dateTime.iso8601>"

      Time.should_receive :from_xml_rpc
      Object.from_xml_rpc xml
    end
  end
end