module Rapuncel
  BUILDER_OPTIONS = {}
  
  def self.get_builder options = {}
    Builder::XmlMarkup.new BUILDER_OPTIONS.merge(options)
  end
end