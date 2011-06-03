require 'rubygems'
require 'bundler/setup'

require 'nokogiri'
require 'rapuncel'
require 'test_server'

module SpecHelper
  def anythings count
    [anything] * count
  end
end

RSpec.configure do |config|
  config.before :all do
    @server = TestServer.new
    @server.start
  end
  
  config.after :all do
    @server.stop
  end
end

String.class_eval do
  def has_xpath? xpath, options = {}
    eq = options[:content]
    count = options[:count] || 1
    doc = Nokogiri::XML.parse self, nil, nil, Nokogiri::XML::ParseOptions::STRICT
    res = doc.xpath xpath

    unless eq
      res.size.should == count
    else
      eq = eq.strip

      if count
        res.to_a.select{ |node|
          node.text.strip == eq
        }.size.should == count
      else
        res.to_a.all?{ |node|
          node.text.strip == eq
        }.should == true
      end
    end
  end
end
