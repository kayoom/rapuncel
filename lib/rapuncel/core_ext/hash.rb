class Hash
  # Hash will be translated into an XML-RPC "struct" object

  def to_xml_rpc b = Rapuncel.get_builder
    b.struct do |b|
      self.each_pair do |key, value|
        b.member do |b|
          key = key.to_s("F") if BigDecimal === key
          b.name key.to_s

          b.value do |b|
            value.to_xml_rpc b
          end
        end
      end
    end

    b.to_xml
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
