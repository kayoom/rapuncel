require 'test_helper'

class ProxyTest < ActiveSupport::TestCase
  class TestClient
    def call_to_ruby request, *args
      [request] + args
    end
  end

  test "Proxy should still provide __ methods" do
    t = Object.new
    t.expects(:call_to_ruby).never

    p = Rapuncel::Proxy.new t

    p.__inspect__
    p.__tap__ {}
    p.__freeze__
  end

  test "Proxy should delegate standard Object instance methods to Client" do
    t = TestClient.new

    p = Rapuncel::Proxy.new t
    request = p.inspect

    assert_equal 'inspect', request.first
  end

  test "Proxy should delegate non-existing methods to Client" do
    t = TestClient.new

    p = Rapuncel::Proxy.new t
    request = p.whatever 'arg1', 'foobar', 1234

    assert_equal 'whatever', request.first
    assert_equal ['arg1', 'foobar', 1234], request[1..-1]
  end

  test "Proxy should dynamically define methods as soon as needed" do
    t = TestClient.new

    p = Rapuncel::Proxy.new t

    assert p.respond_to?('foobar')
    assert !Rapuncel::Proxy.instance_methods.include?('foobar')

    p.foobar

    assert Rapuncel::Proxy.instance_methods.include?('foobar')
  end
end
