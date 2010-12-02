require "xmlrpc/server"

class Num
  INTERFACE = XMLRPC::interface("num") {
    meth 'int add(int, int)', 'Add two numbers', 'add'
    meth 'int div(int, int)', 'Divide two numbers'
  }

  def add(a, b) a + b end
  def div(a, b) a / b end
end


class TestServer
  def initialize
    @server = XMLRPC::Server.new(8080, '127.0.0.1', 4, File.open('/dev/null','w')).tap do |s|
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