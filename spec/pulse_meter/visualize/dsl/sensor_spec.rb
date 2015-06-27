require 'spec_helper'

describe PulseMeter::Visualize::DSL::Sensor do
  let(:interval){ 100 }
  let(:name) { "some_sensor" }
  let!(:sensor){ PulseMeter::Sensor::Timelined::Max.new(name, :ttl => 1000, :interval => interval) }

  describe '.new' do
    it "saves passed name and create Visualize::Sensor with it" do
      expect(described_class.new(name).to_data.name.to_s).to eq(name)
    end
  end

  describe '#process_args' do
    it "passes args transparently to Visualize::Sensor" do
      s = described_class.new(name)
      s.process_args color: :red
      expect(s.to_data.color.to_s).to eq('red')
    end
  end

  describe '#to_data' do
    # actually tested above
    it "converts dsl data to sensor" do
      expect(described_class.new(name).to_data).to be_kind_of(PulseMeter::Visualize::Sensor)
    end
  end

end

