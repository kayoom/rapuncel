require 'spec_helper'
require 'logger'

describe Rapuncel::Client do
  let(:logger) { nil }
  subject { Rapuncel::Client.new :logger => logger }
  
  it { should_not respond_to :logger }
  it { should_not respond_to :log_level }
  
  describe "with Logging enabled" do
    let(:logger) { Logger.new(STDOUT) }
    
    it { should respond_to :logger }
    it { should respond_to :log_level }
  end
end
