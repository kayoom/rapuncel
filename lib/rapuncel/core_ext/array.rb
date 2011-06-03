class Array
  def to_xml_rpc builder = Rapuncel.get_builder
    builder.array do |builder|
      builder.data do |builder|
        each do |array_entry|
          builder.value do |builder|
            array_entry.to_xml_rpc builder
          end
        end
      end
    end

    builder.to_xml
  end

  def self.from_xml_rpc xml_node
    values = xml_node.first_element_child.element_children

    values.map do |value|
      Object.from_xml_rpc value.first_element_child
    end
  end
end
