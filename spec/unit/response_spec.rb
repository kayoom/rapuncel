require 'spec_helper'

describe Rapuncel::Response do
  class HttpResponse
    attr_accessor :body, :code

    def initialize body, success = true, code = 200
      @body, @success, @code = body, success, code
    end

    def success?
      @success
    end
  end
  
  it 'parses successful response' do
    successful_response = HttpResponse.new <<-XML
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
    
    response = Rapuncel::Response.new successful_response, Rapuncel::XmlRpc::Deserializer
    response.should be_success
    
    response.result.should == "foo foo foo"
  end
  
  it 'parses fault response' do
    fault_response = HttpResponse.new <<-XML
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
    
    response = Rapuncel::Response.new fault_response, Rapuncel::XmlRpc::Deserializer
    response.should be_fault
    
    response.to_ruby.should be_a Hash
    response.to_ruby[:faultCode].should == 42
  end
  
  it 'should handle errors' do
    error_response = HttpResponse.new "Not Found", false, 404
    
    response = Rapuncel::Response.new error_response, Rapuncel::XmlRpc::Deserializer
    response.should be_error
    
    response.to_ruby.should be_a Hash
    response.to_ruby[:http_code].should == 404
  end
end
