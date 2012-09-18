require 'spec_helper'

describe NilClass do
  it 'serializes like false' do
    Rapuncel::XmlRpc::Serializer[nil].should have_xpath('/boolean', :content => '0')
  end
end
