require 'test_helper'

class ConnectionTest < ActiveSupport::TestCase
  test "Connection.new should return an AuthConnection if user, password or auth_method is set" do
    assert_kind_of Rapuncel::AuthConnection, Rapuncel::Connection.build(:auth_method => 'basic')
    assert_kind_of Rapuncel::AuthConnection, Rapuncel::Connection.build(:user => '')
    assert_kind_of Rapuncel::AuthConnection, Rapuncel::Connection.build(:password => '')
  end
  
  test "Connection.new should return an ApiKeyAuthConnection if api_key is set" do
    assert_kind_of Rapuncel::ApiKeyAuthConnection, Rapuncel::Connection.build(:api_key => 'xyz')
  end
  
  test "ApiKeyAuthConnection should contain api key in headers" do
    assert_equal 'xyz', Rapuncel::Connection.build(:api_key => 'xyz').headers['X-ApiKey']
  end
end
