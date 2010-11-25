require 'test_helper'

class ObjectTest < ActiveSupport::TestCase
  test "Object.from_xml_rpc should accept nodes as strings" do
    xml = "<int>42</int>"
    
    Integer.expects :from_xml_rpc    
    Object.from_xml_rpc xml
  end
  
  test "Object.from_xml_rpc should accept Nokogiri nodes" do
    xml = Nokogiri::XML.parse("<int>42</int>").root
    
    Integer.expects :from_xml_rpc
    Object.from_xml_rpc xml
  end
  
  test "Object.from_xml_rpc should delegate int nodes" do
    xml = "<int>42</int>"
    
    Integer.expects :from_xml_rpc    
    Object.from_xml_rpc xml
  end
  
  test "Object.from_xml_rpc should delegate string nodes" do
    xml = "<string>foo<string>"
    
    String.expects :from_xml_rpc    
    Object.from_xml_rpc xml
  end
  
  test "Object.from_xml_rpc should delegate array nodes" do
    xml = "<array>42</array>"
    
    Array.expects :from_xml_rpc    
    Object.from_xml_rpc xml
  end
  
  test "Object.from_xml_rpc should delegate hash nodes" do
    xml = "<struct>42</struct>"
    
    Hash.expects :from_xml_rpc    
    Object.from_xml_rpc xml
  end
  
  test "Object.from_xml_rpc should delegate boolean nodes" do
    xml = "<boolean>1</boolean>"
    
    Rapuncel::Boolean.expects :from_xml_rpc    
    Object.from_xml_rpc xml
  end
  
  test "Object.from_xml_rpc should delegate double nodes" do
    xml = "<double>42.23</double>"
    
    Float.expects :from_xml_rpc    
    Object.from_xml_rpc xml
  end
  
  test "Object.from_xml_rpc should delegate Time nodes" do
    xml = "<dateTime.iso8601>2010-11-25T11:44:46+01:00</dateTime.iso8601>"
    
    Time.expects :from_xml_rpc
    Object.from_xml_rpc xml
  end
end