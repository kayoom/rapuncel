require 'spec_helper'

describe NilClass do
  it 'serializes like false' do
    nil.to_xml_rpc.should have_xpath('/boolean', :content => '0')
  end
end