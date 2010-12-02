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


    assert r.success?
    assert !r.fault?
    assert !r.error?
    assert_equal "foo foo foo", r.to_ruby
    assert_equal "foo foo foo", r.result
  end

  test "Response should handle faults" do
    mock = MockReponse.new <<-XML
      <?xml version='1.0'?>
      <methodResponse>
        <fault>
          <value>
            <struct>
              <member>
                <name>
                  faultCode
                </name>
                <value>
                  <int>
                    42
                  </int>
                </value>
              </member>
              <member>
                <name>
                  faultString
                </name>
                <value>
                  <string>
                    Don't panic.
                  </string>
                </value>
              </member>
            </struct>
          </value>
        </fault>
      </methodResponse>
    XML

    r = Rapuncel::Response.new mock

    assert r.fault?
    assert !r.success?
    assert !r.error?

    assert_kind_of Rapuncel::Response::Fault, r.to_ruby
    assert_kind_of Rapuncel::Response::Fault, r.fault

    assert_equal 42, r.fault.code
  end

  test "Response should handle errors" do
    mock = MockReponse.new "Not Found", false, 404

    r = Rapuncel::Response.new mock

    assert r.error?
    assert !r.fault?
    assert !r.success?

    assert_kind_of Rapuncel::Response::Error, r.to_ruby
    assert_kind_of Rapuncel::Response::Error, r.error

    assert_equal 404, r.error.code
  end
end
