if RUBY_VERSION =~ /^1\.8/
  require 'base64'
end

class String
  def as_base64
    Rapuncel::Base64String.new self
  end
end

module Rapuncel
  class Base64String < String
    def base64_encoded
      if RUBY_VERSION =~ /^1\.9/
        [self].pack 'm'
      else
        Base64.encode64 self
      end
    end
    
    class << self
      def decode_base64 string
        if RUBY_VERSION =~ /^1\.9/
          new string.unpack('m')[0]
        else
          new Base64.decode64 string
        end
      end
    end
  end
end
