require 'test_helper'


class ResponseTest < ActiveSupport::TestCase
  class MockReponse
    attr_accessor :body, :code

    def initialize body, success = true, code = 200
      @body, @success, @code = body, success, code
    end

    def success?
      @success
    end
  end

  test 'Response should not be an Array' do
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

    assert_equal "foo foo foo", r.to_ruby
  end
  
end
