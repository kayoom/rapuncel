require 'rapuncel/request'

module Rapuncel
  class Proxy
    PROXY_METHODS  = %w(tap inspect clone freeze dup class initialize)
    LOCKED_METHODS = %w(method_missing)
    LOCKED_PATTERN = /(\A__|\?\Z|!\Z)/
    
    class << self
      def new client
        allocate.__tap__ do |new_proxy|
          new_proxy.__initialize__ client
        end
      end
    
      def define_proxy_method name
        define_method name do |*args|
          call! name, *args
        end
      end
    end
    
    PROXY_METHODS.each do |name|
      alias_method "__#{name}__", name
    end
    
    instance_methods.each do |name|
      unless LOCKED_METHODS.include?(name) || LOCKED_PATTERN.match(name)
        define_proxy_method name
      end
    end
    
    def call! name, *args
      @client.execute_to_ruby Request.new(name, *args)
    end
    
    def __initialize__ client
      @client = client
    end
    
    protected
    def method_missing name, *args
      name = name.to_s
      
      if LOCKED_PATTERN.match name
        super
      else
        self.__class__.define_proxy_method name
        call! name, *args
      end
    end
  end
end