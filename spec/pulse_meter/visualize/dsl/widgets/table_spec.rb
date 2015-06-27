require 'spec_helper'

describe PulseMeter::Visualize::DSL::Widgets::Table do
  it_should_behave_like "dsl widget"

  let(:interval){ 100 }
  let(:name) { "some_sensor" }
  let!(:sensor){ PulseMeter::Sensor::Timelined::Max.new(name, :ttl => 1000, :interval => interval) }

  let(:widget_name){ "some_widget" }
  let(:w){ described_class.new(widget_name)  }

  describe "#to_data" do
    it "produces PulseMeter::Visualize::Widgets::Area class" do
      expect(w.to_data).to be_kind_of(PulseMeter::Visualize::Widgets::Table)
    end
  end

  describe "#show_last_point" do
    it "sets show_last_point" do
      w.show_last_point true
      expect(w.to_data.show_last_point).to eq(true)
    end
  end

  describe "#timespan" do
    it "sets timespan" do
      w.timespan 5
      expect(w.to_data.timespan).to eq(5)
    end
    it "raises exception if timespan is negative" do
      expect{ w.timespan(-1) }.to raise_exception(PulseMeter::Visualize::DSL::BadWidgetTimeSpan)
    end
  end
end

