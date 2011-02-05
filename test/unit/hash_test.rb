require 'test_helper'
require 'active_support/core_ext/hash/keys'

class TestHelper < ActiveSupport::TestCase




  def to_and_from_xml_rpc hash
    xml = hash.to_xml_rpc

    xml_node = Nokogiri::XML(xml).children.first

    Hash.from_xml_rpc xml_node
  end

  test 'Hash#to_xml_rpc' do
    xml = {
      :abc => 'one and two',
      40 => %w(foo bar bee)
    }.to_xml_rpc

    assert_select xml, '/struct', 1
    assert_select xml, '/struct/member', 2
    assert_select xml, '/struct/member/name', 'abc', 1
    assert_select xml, '/struct/member/value/string', 'one and two', 1
    assert_select xml, '/struct/member/name', '40', 1
    assert_select xml, '/struct/member/value/array/data/value', 3
  end


  test "A hash to xml and back should be itself" do
    hash1 = {:a => "b", :c => "d", :A => "B"}
    arr1 = (1..10).to_a
    hash2 = {:arr => arr1, :text => "sheeee"}
    hash3 = hash1.merge({:jooooo => hash2})

    hash4 = Hash[*(1..10).to_a] #separate, non symbol keys

    hashes = [hash1, hash2, hash3]

    results = hashes.map do |h|
      to_and_from_xml_rpc h
    end

    result4 = to_and_from_xml_rpc hash4 #separate, non symbol keys

    hashes.zip(results).each do |hr|
      assert_equal *hr
    end

    assert_equal hash4.stringify_keys.symbolize_keys, result4
  end
end