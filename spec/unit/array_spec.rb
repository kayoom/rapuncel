require 'spec_helper'

describe Array do
  describe "Serialization" do
    before do
      @array = (1..10).to_a.map &:to_s

      @xml = Rapuncel::XmlRpc::Serializer[@array]
    end

    it "yields a value tag for each array element" do
      @xml.should have_xpath('/array/data/value', :count => 10)
    end

    it "preserves the element order" do
      @xml.should have_xpath('/array/data/value[4]/string', :content => "4")
      @xml.should have_xpath('/array/data/value[5]/string', :content => "5")
    end
  end

  describe "Deserialization" do
    before do
      @xml = <<-XML
        <array><data>
          <value><string>1</string></value>
          <value><string>2</string></value>
          <value><string>3</string></value>
        </data></array>
      XML
      @array = Rapuncel::XmlRpc::Deserializer[@xml]
    end

    it 'has correct number of elements' do
      @array.count.should == 3
    end

    it 'preserves element order' do
      @array.should == ["1", "2", "3"]
    end
  end
end
