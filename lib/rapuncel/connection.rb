module Rapuncel
  class Connection
    attr_accessor :host, :port, :path, :ssl, :user, :password
    alias_method :ssl?, :ssl

    def initialize configuration = {}
      load_configuration configuration
    end

    def url
      "#{protocol}://#{host}:#{port}#{path}"
    end
    
    def host= value
      @host = value.to_s.sub /^http(s)?\:\/\//, ''
      
      if $1 == 's'
        @ssl = true
      end
      
      @host
    end
    
    def path= value
      unless value =~ /^\//
        value = "/" + value
      end
      
      @path = value
    end
    
    def headers= headers
      @headers = {
        'User-Agent' => 'Rapuncel, Ruby XMLRPC Client'
      }.merge headers.stringify_keys
    end

    def headers
      @headers.merge 'Accept' => 'text/xml', 'content-type' => 'text/xml'
    end
    
    def protocol
      ssl? ? 'https' : 'http'
    end
    alias_method :scheme, :protocol
    
    def auth?
      !!user && !!password
    end
    
    protected
    def load_configuration configuration
      configuration = configuration.symbolize_keys
      
      self.ssl      = !!configuration[:ssl]
      self.host     = configuration[:host]    || 'localhost'
      self.port     = configuration[:port]    || '8080'
      self.path     = configuration[:path]    || '/'
      self.headers  = configuration[:headers] || {}
      self.user     = configuration[:user]
      self.password = configuration[:password]
    end
  end
end