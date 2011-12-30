require 'logger'

module Rapuncel
  module Client::Logging
    attr_accessor :logger
    
    def log_level
      @logger.try :level
    end
    
    def log_level= log_level
      @logger && @logger.level = log_level
    end
    
    def logger= logger
      @logger = case logger
      when Logger
        logger
      when IO
        Logger.new logger
      when String, Symbol
        Logger.new ActiveSupport::Inflector.constantize(logger.to_s.upcase)
      else
        Logger.new STDOUT
      end
    end
    
    protected
    def initialize_logging logger, log_level
      self.logger = logger
      if log_level
        self.log_level = log_level
      end
      
      logger.info { with_log_prefix "Initialized." }
      logger.debug { with_log_prefix "Using (De)Serializer: #{serialization.to_s}" }
    end
    
    def _call name, *args
      if logger.debug?
        logger.debug { with_log_prefix "Calling RPC Method \"#{name}\" with #{args.map(&:inspect).join(', ')}" }
      else
        logger.info { with_log_prefix "Calling RPC Method \"#{name}\" with #{args.length} arguments." }
      end
      
      super
    end
    
    def send_method_call xml
      logger.debug { with_log_prefix "Sending XML:\n #{xml}" }
      
      super
    end
    
    def execute request
      super.tap do |response|
        case
        when response.success?
          logger.debug { "Received XML-Response: \n #{response.body}" }
        when response.fault?
          level = raise_on_fault ? :error : :warn
          logger.add(level) { "Received XML-Fault: \n #{response.body}" }
        when response.error?
          level = raise_on_error ? :error : :warn
          logger.add(level) { "HTTP Error: #{response.status}\n #{response.body}" }
        end
      end
    end
    
    private
    def log_host_config
      "#{connection.host}:#{connection.port}#{connection.path}"
    end
    
    def with_log_prefix message
      "#{log_prefix} #{message}"
    end
    
    def log_prefix
      @log_prefix ||= "[XML-RPC@#{log_host_config}]"
    end
  end
end
