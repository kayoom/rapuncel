lib_dir = File.join File.dirname(__FILE__), '..', 'lib'
$:.unshift lib_dir

require 'rubygems'
require 'active_support'
require 'test/unit'
require 'rapuncel'
require 'nokogiri'

class ActiveSupport::TestCase
  def assert_select xml, xpath, eq
    doc = Nokogiri::XML.parse(xml)
    res = doc.xpath(xpath)
    
    eq.nil? && res.blank? && assert(true) && return
    
    case eq
    when Integer
      assert_equal eq, res.size
    when String
      eq = eq.strip
      
      assert res.to_a.all?{ |node|
        node.text.strip == eq
      }
    else
      raise "Third argument should be String or Integer"
    end
  end
end