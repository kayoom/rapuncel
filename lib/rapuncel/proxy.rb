require 'rapuncel/request'

module Rapuncel
  class Proxy
    PROXY_METHODS  = %w(tap inspect clone freeze dup class initialize)
    LOCKED_METHODS = %w(method_missing)
    LOCKED_PATTERN = /(\A__|\?\Z|!\Z)/

    class << self
      def new client_or_configuration, interface = nil        
        client_or_configuration = Client.new client_or_configuration if client_or_configuration.is_a?(Hash)
        
        allocate.__tap__ do |new_proxy|
          new_proxy.__initialize__ client_or_configuration, interface
        end
      end

      def define_proxy_method name
        class_eval <<-RUBY, __FILE__, __LINE__ + 1
          def #{name} *args, &block
            call! '#{name}', *args, &block
          end
        RUBY
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
      name = "#{@interface}.#{name}" if @interface
      
      @client.execute_to_ruby(Request.new(name, *args)).tap do |response|
      
        if block_given?
          yield response
        end
      end
    end

    def __initialize__ client, interface
      @interface = interface
      @client = client
    end

    protected
    def respond_to? name
      LOCKED_PATTERN.match(name.to_s) ? super : true
    end
    
    def method_missing name, *args, &block
      name = name.to_s

      if LOCKED_PATTERN.match name
        super
      else
        self.__class__.define_proxy_method name
        call! name, *args, &block
      end
    end
  end
end
