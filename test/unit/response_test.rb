require 'test_helper'


class ResponseTest < ActiveSupport::TestCase
  class MockReponse
    attr_accessor :body
    
    def initialize body, success = true
      @body, @success = body, success
    end
    
    def success?
      @success
    end
  end
  
  test 'Response should be an Array' do
    mock = MockReponse.new <<-XML
      <?xml version='1.0'?>
      <methodResponse>
        <params>
          <param>
            <value>
              <string>foo foo foo</string>
            </value>
          </param>
        </params>
      </methodResponse>
    XML
    
    r = Rapuncel::Response.new mock
    
    assert_kind_of Array, r.to_ruby
    assert_equal "foo foo foo", r.to_ruby.first
  end
end