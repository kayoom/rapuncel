require 'builder'
require 'nokogiri'

class Symbol
  def to_xml_rpc b = Rapuncel.get_builder
    b.string to_s
  end
end
