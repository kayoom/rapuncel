require 'builder'


class Array
  
  def to_xml_rpc b
    
    b.array do |b|
      b.data do |b|
        self.each do |array_entry|
          b.value do |b|
            array_entry.to_xml_rpc b
          end
        end
      end
    end
    
    
  end
  
  
  
end