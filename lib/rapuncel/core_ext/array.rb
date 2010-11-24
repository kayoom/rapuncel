require 'builder'


class Array

  def to_xml_rpc b = Rapuncel.get_builder

    b.array do
      b.data do
        each do |array_entry|
          b.value do
            array_entry.to_xml_rpc b
          end
        end
      end
    end
  end
end
