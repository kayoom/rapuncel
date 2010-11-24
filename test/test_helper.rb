lib_dir = File.join File.dirname(__FILE__), '..', 'lib'
$:.unshift lib_dir

require 'rubygems'
require 'active_support'
require 'test/unit'
require 'mocha'
require 'rapuncel'
require 'nokogiri'
require 'ruby-debug'

class ActiveSupport::TestCase
  def assert_select xml, xpath, eq, count = nil
    doc = Nokogiri::XML.parse xml, nil, nil, Nokogiri::XML::ParseOptions::STRICT
    res = doc.xpath xpath
    
    eq.nil? && assert(res.blank?) && return
    
    case eq
    when Integer
      assert_equal eq, res.size
    when String
      eq = eq.strip
      
      if count
        assert_equal count, res.to_a.select{ |node|
          node.text.strip == eq
        }.size
      else
        assert res.to_a.all?{ |node|
          node.text.strip == eq
        }
      end        
    else
      raise "Third argument should be String or Integer"
    end
  end
end
