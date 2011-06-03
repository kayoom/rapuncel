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
      
      xml = Rapuncel::XmlRpcSerializer[obj]
      xml.should have_xpath('/struct/member', :count => 2)
      
      reparsed_object = Rapuncel::XmlRpcDeserializer[xml]
      reparsed_object.should == {
        :a => 'one',
        :b => 'two'
      }
    end
  end
end