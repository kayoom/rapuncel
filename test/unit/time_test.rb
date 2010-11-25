require 'test_helper'

class TimeTest < ActiveSupport::TestCase

  test "Time.now should be written down in the iso 8601 standard between dateTime.iso8601 tags" do
    t=Time.now
    xml=t.to_xml_rpc

    assert_select xml, '/dateTime.iso8601', 1
    assert_select xml, '/dateTime.iso8601', t.iso8601
  end
  
  test "A time converted to xml and reparsed should be equal to its starting point" do
    t=Time.now
    xml=t.to_xml_rpc
    
    xml_node=Nokogiri::XML(xml).children.first
    
    reparsed=Time.from_xml_rpc(xml_node)
    
    puts "Original: #{t}"
    puts "Reparsed: #{reparsed}"
    
    assert_equal t.to_i, reparsed.to_i # can't  use assert_equal here! need to find a decent equality operator!!
    #assert
  end

end
