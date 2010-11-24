require 'builder'

# Ruby Core extensions:

require 'rapuncel/core_ext/object'
require 'rapuncel/core_ext/string'
require 'rapuncel/core_ext/integer'
require 'rapuncel/core_ext/big_decimal'
require 'rapuncel/core_ext/float'
require 'rapuncel/core_ext/hash'
require 'rapuncel/core_ext/array'


require 'rapuncel/request'

module Rapuncel
  BuilderOptions = {}
  
  def self.get_builder options = {}
    Builder::XmlMarkup.new BuilderOptions.merge(options)
  end
end