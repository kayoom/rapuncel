require 'builder'

class Float
  
  protected
  def to_xml_rpc_name #we can just change this function. see why in object.rb
    "double"
  end
end
