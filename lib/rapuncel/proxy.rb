require 'rapuncel/request'

module Rapuncel
  class Proxy
    PROXY_METHODS  = %w(tap inspect clone freeze dup class initialize to_s).freeze
    LOCKED_METHODS = %w(method_missing).freeze
    LOCKED_PATTERN = /(\A__|\?\Z|!\Z)/.freeze

    class << self
      # Initialize a new Proxy object for a specific Client. Alternatively
      # you can pass a Hash containing configuration for a new Client, which
      # will be created on-the-fly, but not accessible. The second parameter
      # specifies a specific interface/namespace for the remote calls,
      # i.e. if your RPC method is
      #
      #     int numbers.add(int a, int b)
      #
      # You can create a specific proxy for +numbers+, and use +add+ directly
      #
      #     proxy = Proxy.new client, 'numbers'
      #     proxy.add(40, 2) -> 42
      #
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
    
    alias_method "__inspect__", "__to_s__"

    instance_methods.each do |name|
      unless LOCKED_METHODS.include?(name) || LOCKED_PATTERN.match(name)
        define_proxy_method name
      end
    end

    def call! name, *args
      name = "#{@interface}.#{name}" if @interface

      @client.call_to_ruby(name, *args).tap do |response|

        if block_given?
          yield response
        end
      end
    end

    def __initialize__ client, interface #:nodoc:
      @interface = interface
      @client = client
    end

    def respond_to? name #:nodoc:
      LOCKED_PATTERN.match(name.to_s) ? super : true
    end

    protected
    def method_missing name, *args, &block #:nodoc:
      name = name.to_s

      if LOCKED_PATTERN.match name
        super name.to_sym, *args, &block
      else
        self.__class__.define_proxy_method name
        call! name, *args, &block
      end
    end
  end
end
