require "xmlrpc/server"
require 'rubygems'

class Num
  INTERFACE = XMLRPC::interface("num") {
    meth 'int add(int, int)', 'Add two numbers', 'add'
    meth 'int div(int, int)', 'Divide two numbers'
  }

  def add(a, b) a + b end
  def div(a, b) a / b end
end

class TestServer
  attr_accessor :server
  
  def initialize
    @server = XMLRPC::Server.new(9485, '127.0.0.1', 4, File.open('/dev/null','w')).tap do |s|
      s.add_handler(Num::INTERFACE, Num.new)
    end
  end

  def start
    Thread.new { @server.serve }
  end

  def stop
    @server.shutdown
  end
end