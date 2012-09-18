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

  describe "log devices" do
    describe 'Symbol' do
      let(:logger) { :stdout }

      its(:logger) { should be_a Logger }
    end

    describe 'String' do
      let(:logger) { 'stdout' }

      its(:logger) { should be_a Logger }
    end

    describe 'IO' do
      let(:logger) { File.open('/dev/null', 'w') }

      its(:logger) { should be_a Logger }
    end

    describe 'true' do
      let(:logger) { true }

      its(:logger) { should be_a Logger }
    end
  end
end
