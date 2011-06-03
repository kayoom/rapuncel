class Hash
  def to_xml_rpc builder = Rapuncel.get_builder
    builder.struct do |builder|
      self.each_pair do |key, value|
        builder.member do |builder|
          # Get a better string representation of BigDecimals
          key = key.to_s("F") if BigDecimal === key
          builder.name key.to_s

          builder.value do |builder|
            value.to_xml_rpc builder
          end
        end
      end
    end

    builder.to_xml
  end

  def self.from_xml_rpc xml_node
    keys_and_values = xml_node.element_children

    new.tap do |hash|
      keys_and_values.each do |kv|
        key = kv.first_element_child.text.strip.to_sym
        value = Object.from_xml_rpc kv.last_element_child.first_element_child

        hash[key] = value
      end
    end
  end
end
