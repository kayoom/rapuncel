require 'time'

class Time

  def to_xml_rpc b=Rapuncel.get_builder
    b.send "dateTime.iso8601", self.iso8601

    b.to_xml
  end

  def self.from_xml_rpc xml_node
    Time.parse xml_node.text.strip #make a Time object of this string which is hopefully in the right format
  end
end
