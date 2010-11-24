require 'test_helper'

class ClientTest < ActiveSupport::TestCase
  test "bla" do
    client = Rapuncel::Client.new :port => 8000
    proxy = Rapuncel::Proxy.new client
    debugger
    puts 'bla'
  end
end