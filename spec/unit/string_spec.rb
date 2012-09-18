require 'spec_helper'

describe String, Symbol do
  it 'serialization of a String' do
    string = "foobar"
    xml = Rapuncel::XmlRpc::Serializer[string]
    xml.should have_xpath('/string', :content => "foobar")
  end

  it 'serialization of a Symbol' do
    symbol = :foobar
    xml = Rapuncel::XmlRpc::Serializer[symbol]
    xml.should have_xpath('/string', :content => "foobar")
  end

  it 'preservation of trailing an leading whitespaces' do
    string = "\n\t  abcd\n  \t"
    xml = Rapuncel::XmlRpc::Serializer[string]
    xml.should have_xpath('/string', :content => "\n\t  abcd\n  \t")
  end

  it 'deserialization of a String' do
    xml = <<-XML
      <string>abcd\nefgh  \n\t</string>
    XML
    string = Rapuncel::XmlRpc::Deserializer[xml]
    string.should == "abcd\nefgh  \n\t"
  end

  it 'normalization of linebreaks' do
    string = "one\r\ntwo\rthree\nfour"
    string2 = Rapuncel::XmlRpc::Deserializer[Rapuncel::XmlRpc::Serializer[string]]
    string2.should == "one\ntwo\nthree\nfour"
  end
end
