require 'spec_helper'
require 'active_support/core_ext/hash/keys'

describe Hash do
  describe "Serialization" do
    before do
      @hash = {
        :abc => 'one and two',
        40 => %w(foo bar bee),
        BigDecimal.new('1.23') => "abcd"
      }
      
      @xml = @hash.to_xml_rpc
    end
    
    it 'preserves number of key-value pairs' do
      @xml.should have_xpath('/struct/member', :count => 3)
    end
    
    it 'projects all keys to plain strings' do
      @xml.should have_xpath('/struct/member/name', :content => 'abc')
      @xml.should have_xpath('/struct/member/name', :content => '40')
      @xml.should have_xpath('/struct/member/name', :content => '1.23')
    end
  end
  
  describe "Deserialization" do
    before do
      @xml = <<-XML
        <struct>
        <member><name>abcd</name>
        <value><int>123></int></value></member>
        <member><name>456</name>
        <value><string>xyz</string></value></member>
        </struct>
      XML
      
      @hash = Object.from_xml_rpc @xml
    end
    
    it 'preserves number of key-value pairs' do
      @hash.length.should == 2
    end
    
    it 'converts all keys to symbols' do
      @hash.keys.should be_all{|key| Symbol === key}
    end
    
    it 'casts values to their types' do
      @hash[:abcd].should == 123
      @hash[:'456'].should == 'xyz'
    end
  end
end
