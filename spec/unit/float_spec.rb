require 'spec_helper'

describe Float do
  describe "Serialization" do
    it "can serialize Floats" do
      number = 1.23456
      Rapuncel::XmlRpc::Serializer[number].should have_xpath('/double', :content => "1.23456")
    end

    it "can serialize BigDecimal" do
      number = BigDecimal.new '1.23456'
      Rapuncel::XmlRpc::Serializer[number].should have_xpath('/double', :content => "1.23456")
    end
  end

  describe "Deserialization" do
    it "can deserialize double" do
      xml = <<-XML
        <double>1.23456</double>
      XML
      number = Rapuncel::XmlRpc::Deserializer[xml]
      number.should be_a Float
      number.should == 1.23456
    end

    it "can optionally deserialize all double to BigDecimal" do
      Rapuncel::XmlRpc::Deserializer.double_as_bigdecimal = true

      xml = <<-XML
        <double>1.23456</double>
      XML
      number = Rapuncel::XmlRpc::Deserializer[xml]

      number.should be_a BigDecimal
      number.to_s("F").should == "1.23456"
    end
  end
end
