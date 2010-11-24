require 'builder'
require 'time'


class Time

  def to_xml_rpc b=Rapuncel.get_builder
    b.tag! "dateTime.iso8601", self.iso8601
  end
end
