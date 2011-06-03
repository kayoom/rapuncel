require 'spec_helper'

describe Time do
  it 'serialization' do
    time = Time.now
    xml = Rapuncel::XmlRpcSerializer[time]
    xml.should have_xpath('/dateTime.iso8601', :content => time.iso8601)
  end
  
  it 'deserialization' do
    time = Time.now
    xml = <<-XML
      <dateTime.iso8601>#{time.iso8601}</dateTime.iso8601>
    XML
    
    parsed_time = Rapuncel::XmlRpcDeserializer[xml]
    parsed_time.should be_a Time
    parsed_time.to_i.should == time.to_i
  end
end
