require 'test_helper'

class ArrayTest < ActiveSupport::TestCase

  test "an array of 10 entries should have 10x /array/data/value" do
    arr = (1..10).to_a.map &:to_s
    xml = arr.to_xml_rpc

    assert_select xml, '/array/data/value', 10
  end

  def test_array arr
    xml = arr.to_xml_rpc

    xml_node = Nokogiri::XML(xml).children.first

    reparsed = Array.from_xml_rpc xml_node

    reparsed
  end


  test "An array, converted to xml and parsed back should be itself" do
    arr1 = (1..10).to_a
    arr2 = arr1.map &:to_s

    arr3 = [arr1, arr2]

    arr4 = ["hello", arr3]

    reparsed1 = test_array arr1
    reparsed2 = test_array arr2
    reparsed3 = test_array arr3
    reparsed4 = test_array arr4

    [reparsed1, reparsed2, reparsed3, reparsed4].zip([arr1, arr2, arr3, arr4]).each do |b|
      assert_equal *b
    end

  end

  test "real world repsonse" do
    response_body = <<-XML
      <array><data>
      <value><struct>
      <member>
      <name>state</name>
      <value><string>uninstalled</string></value>
      </member>
      <member>
      <name>name</name>
      <value><string>account_cancel</string></value>
      </member>
      <member>
      <name>id</name>
      <value><int>1</int></value>
      </member>
      </struct></value>
      <value><struct>
      <member>
      <name>state</name>
      <value><string>uninstalled</string></value>
      </member>
      <member>
      <name>name</name>
      <value><string>document_ftp</string></value>
      </member>
      <member>
      <name>id</name>
      <value><int>3</int></value>
      </member>
      </struct></value>
      <value><struct>
      <member>
      <name>state</name>
      <value><string>uninstalled</string></value>
      </member>
      <member>
      <name>name</name>
      <value><string>mrp_repair</string></value>
      </member>
      <member>
      <name>id</name>
      <value><int>2</int></value>
      </member>
      </struct></value>
      </data></array>
    XML

    arr = Object.from_xml_rpc response_body

    assert_kind_of Array, arr
    assert_equal 3, arr.size
  end

end
