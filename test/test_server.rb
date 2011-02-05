require "xmlrpc/server"
require 'rubygems'
require 'faker'

class Num
  INTERFACE = XMLRPC::interface("num") {
    meth 'int add(int, int)', 'Add two numbers', 'add'
    meth 'int div(int, int)', 'Divide two numbers'
    meth 'int rows', "Return a bunch of hashes"
  }

  def add(a, b) a + b end
  def div(a, b) a / b end
  
  def initialize
    @rows = []

    10000.times do |i|
      @rows << {
        :first_name => Faker::Name.first_name,
        :last_name => Faker::Name.last_name,
        :street => Faker::Address.street_name,
        :zip_code => Faker::Address.zip_code,
        :city => Faker::Address.city,
        :us_state => Faker::Address.us_state,
        :company => Faker::Company.name
      }
    end
  end
  
  
  def rows
    @rows
  end
end


class TestServer
  attr_accessor :server
  
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