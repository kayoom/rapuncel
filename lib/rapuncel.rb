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

# Ruby Core extensions:
require 'rapuncel/core_ext/object'
require 'rapuncel/core_ext/string'
require 'rapuncel/core_ext/symbol'
require 'rapuncel/core_ext/integer'
require 'rapuncel/core_ext/big_decimal'
require 'rapuncel/core_ext/float'
require 'rapuncel/core_ext/hash'
require 'rapuncel/core_ext/array'
require 'rapuncel/core_ext/boolean'
require 'rapuncel/core_ext/nil'
require 'rapuncel/core_ext/time'
