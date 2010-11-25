require 'test_helper'
require 'test_server'

class FunctionalTest < ActiveSupport::TestCase  
  def setup
    @test_server = TestServer.new
    @test_server.start
  end
  
  def teardown
    @test_server.stop
  end
end