require 'test_helper'

class TimeTest < ActiveSupport::TestCase

  test "Time.now should be written down in the iso 8601 standard between dateTime.iso8601 tags" do
    t=Time.now
    xml=t.to_xml_rpc

    assert_select xml, '/dateTime.iso8601', 1
    assert_select xml, '/dateTime.iso8601', t.iso8601
  end

end
