require 'test_helper'

class ClientTest < ActiveSupport::TestCase
  test "bla" do
    client = Rapuncel::Client.new :port => 8000
    debugger
    puts 'bla'
  end
end