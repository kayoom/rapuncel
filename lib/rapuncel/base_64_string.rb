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

    if RUBY_VERSION =~ /^1\.9/

      def base64_encoded
        [self].pack 'm'
      end

      def self.decode_base64 string
        new string.unpack('m')[0]
      end

    else

      def base64_encoded
        Base64.encode64 self
      end

      def self.decode_base64 string
        new Base64.decode64 string
      end

    end
  end
end
