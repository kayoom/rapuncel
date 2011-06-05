require 'spec_helper'

describe "Base64" do
  def to_base64 string
    if RUBY_VERSION =~ /^1\.9/
      [string].pack('m')
    else
      require 'base64'
      Base64.encode64(string)
    end
  end
  
  it 'should encode Base64 marked strings as Base64' do
    string = "abcdefghABCDEFGH1234567890".as_base64
    string.should be_a Rapuncel::Base64String
    
    xml = Rapuncel::XmlRpcSerializer[string]
    xml.should have_xpath('/base64', :content => to_base64(string))
  end
  
  it 'should decode base64 as Base64Strings' do
    xml = <<-XML
      <base64>YWJjZGVmZ2hBQkNERUZHSDEyMzQ1Njc4OTA=</base64>
    XML
    
    string = Rapuncel::XmlRpcDeserializer[xml]
    string.should be_a Rapuncel::Base64String
    string.should == "abcdefghABCDEFGH1234567890"
  end
end