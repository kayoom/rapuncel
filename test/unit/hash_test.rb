require 'test_helper'

class TestHelper < ActiveSupport::TestCase
  
  
  
  
  def to_and_from_xml_rpc hash, verbose=false
    xml = hash.to_xml_rpc
    puts xml if verbose
    xml_node = Nokogiri::XML(xml).children.first
    
    Hash.from_xml_rpc xml_node
  end
  
  
  test "A hash to xml and back should be itself" do
    hash1 = {:a => "b", :c => "d", :A => "B"}
    arr1 = (1..10).to_a
    hash2 = {:arr => arr1, :text => "sheeee"}
    hash3 = hash1.merge({:jooooo => hash2})
    
    hashes = [hash3]#[hash1, hash2, hash3]
    
    results = hashes.map do |h|
      to_and_from_xml_rpc h, true
    end
    
    hashes.zip(results).each do |hr|
      assert_equal *hr
    end
  end
    
    
  
  
end