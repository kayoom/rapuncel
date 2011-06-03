require 'time'

class Time

  def to_xml_rpc builder = Rapuncel.get_builder
    builder.send "dateTime.iso8601", iso8601

    builder.to_xml
  end

  def self.from_xml_rpc xml_node
    Time.parse xml_node.text.strip
  end
end
