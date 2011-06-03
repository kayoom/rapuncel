require 'spec_helper'

describe String, Symbol do
  it 'serialization of a String' do
    string = "foobar"
    
    string.to_xml_rpc.should have_xpath('/string', :content => "foobar")
  end
  
  it 'serialization of a Symbol' do
    symbol = :foobar
    
    symbol.to_xml_rpc.should have_xpath('/string', :content => "foobar")
  end
  
  it 'preservation of trailing an leading whitespaces' do
    string = "\n\t  abcd\n  \t"
    
    string.to_xml_rpc.should have_xpath('/string', :content => "\n\t  abcd\n  \t")
  end
  
  it 'normalization of linebreaks' do
    string = "one\r\ntwo\rthree\nfour"
    
    Object.from_xml_rpc(string.to_xml_rpc).should == "one\ntwo\nthree\nfour"
  end
end