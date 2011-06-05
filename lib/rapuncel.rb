require 'active_support/core_ext/hash/keys'
require 'nokogiri'

module Rapuncel
  BUILDER_OPTIONS = {:encoding => 'UTF-8'}

  def self.get_builder options = {}
    Nokogiri::XML::Builder.new options
  end
end

require 'rapuncel/request'
require 'rapuncel/response'
require 'rapuncel/client'
require 'rapuncel/proxy'

require 'rapuncel/base_64_string'