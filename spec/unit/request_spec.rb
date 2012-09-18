require 'spec_helper'


describe Rapuncel::Request do
  describe "Serialization" do
    before do
      @request = Rapuncel::Request.new 'test_method', "one argument", "another"
      @xml = Rapuncel::XmlRpc::Serializer[@request]
    end

    it 'should be in xml version=1.0' do
      @xml.should =~ /<\?xml version=['"]1.0['"]/
    end

    it 'should contain a methodCall' do
      @xml.should have_xpath('/methodCall', :count => 1)
    end

    it 'should contain the method name' do
      @xml.should have_xpath('/methodCall/methodName', :content => "test_method")
    end

    it 'should contain the method arguments in correct order' do
      @xml.should have_xpath('/methodCall/params/param[1]/value/string', :content => "one argument")
      @xml.should have_xpath('/methodCall/params/param[2]/value/string', :content => "another")
    end
  end
end
