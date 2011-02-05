module Rapuncel
  BUILDER_OPTIONS = {:encoding => 'UTF-8'}

  def self.get_builder options = {}
    Nokogiri::XML::Builder.new options
  end
end