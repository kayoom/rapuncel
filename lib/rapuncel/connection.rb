module Rapuncel
  class Connection
    def self.build configuration = {}
      configuration = configuration.symbolize_keys
      
      case
      when configuration[:user], configuration[:auth_method], configuration[:password]
        AuthConnection.new configuration
      when configuration[:api_key_header], configuration[:api_key]
        ApiKeyAuthConnection.new configuration
      else
        new configuration
      end
    end
    
    attr_accessor :host, :port, :path, :ssl, :headers
    
    alias_method :ssl?, :ssl
    
    def initialize configuration = {}
      
      @host     = configuration[:host]    || 'localhost'
      @port     = configuration[:port]    || '80'
      @path     = configuration[:path]    || '/'
      @headers  = configuration[:headers] || {}
      
      
      if ssl = configuration[:ssl]
        @ssl = true
        #TODO
      end
    end
    
    def url
      "http://#{host}:#{port}#{path}"
    end
    
    def http_auth? ; false ; end
    def api_auth? ; false ; end
  end
  
  class AuthConnection < Connection
    attr_accessor :auth_method, :user, :password
    
    def initialize configuration = {}
      super
      
      @auth_method  = auth_method               || 'basic'
      @user         = user                      || ''
      @password     = configuration[:password]  || ''
    end
    
    def http_auth? ; true ; end
  end
  
  class ApiKeyAuthConnection < Connection
    attr_accessor :api_key_header, :api_key
    
    def initialize configuration = {}
      super
            
      @api_key_header = configuration[:api_key_header] || "X-ApiKey"
      @api_key        = configuration[:api_key]        || '' #DISCUSS: raise error ?
    end
    
    def headers
      super.merge api_key_header => api_key
    end
    
    def api_auth? ; true ; end
  end
end