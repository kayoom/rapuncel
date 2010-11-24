require 'builder'

class String
  
  protected
  def to_xml_rpc_name #this suffices. go to object.rb to see why
    "string"
  end
end
