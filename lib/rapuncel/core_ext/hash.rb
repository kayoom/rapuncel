require 'builder'

class Hash
  #Hash will be translated into an XML-RPC "struct" object
  
  def to_xml_rpc b = Rapuncel.get_builder
    
    b.struct do |b|
      self.each_pair do |key, value|
        
        warn "The key #{key.to_s} is a #{key.class.to_s}, which is neither a symbol nor a string. It will be converted using to_s" unless key.is_a?(String) || key.is_a?(Symbol)
        
        b.member do
          
          b.name key.to_s
          b.value do
            value.to_xml_rpc b
          end
        end
      end
    end
  end
end
