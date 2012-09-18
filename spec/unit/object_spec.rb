require 'spec_helper'

describe Object do
  class TestObject
    attr_accessor :a, :b, :c
  end

  class TestObjectWithOwnBehavior < TestObject
    def to_xmlrpc serializer
      serializer.builder.string "custom thing"
    end
  end

  describe "Serialization of an arbitrary Object" do
    it "serializes all instance variables like a hash" do
      obj = TestObject.new
      obj.a = "one"
      obj.b = "two"

      xml = Rapuncel::XmlRpc::Serializer[obj]
      xml.should have_xpath('/struct/member', :count => 2)

      reparsed_object = Rapuncel::XmlRpc::Deserializer[xml]
      reparsed_object.should == {
        :a => 'one',
        :b => 'two'
      }
    end

  end

  describe "Serialization of an Object with #to_xmlrpc" do
    it "uses this method to serialize" do
      obj = TestObjectWithOwnBehavior.new

      obj.a = 'one'

      xml = Rapuncel::XmlRpc::Serializer[obj]
      xml.should have_xpath('/string')

      reparsed_object = Rapuncel::XmlRpc::Deserializer[xml]
      reparsed_object.should == "custom thing"
    end
  end
end
