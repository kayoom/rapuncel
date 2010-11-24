require 'test_helper'

class ArrayTest < ActiveSupport::TestCase

  test "an array of 10 entries should have 10x /array/data/value" do
    arr = (1..10).to_a.map &:to_s
    xml = arr.to_xml_rpc

    assert_select xml, '/array/data/value', 10
  end
end
