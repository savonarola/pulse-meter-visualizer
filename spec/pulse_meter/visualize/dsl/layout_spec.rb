require 'spec_helper'

describe PulseMeter::Visualize::DSL::Layout do
  let(:interval){ 100 }
  let(:sensor_name) { "some_sensor" }
  let!(:sensor){ PulseMeter::Sensor::Timelined::Max.new(sensor_name, :ttl => 1000, :interval => interval) }
  let(:layout){ described_class.new }

  describe '.new' do
    it "initializes pages, title, use_utc, gchart_options" do
      l = layout.to_data
      expect(l.title).to eq(PulseMeter::Visualize::DSL::Layout::DEFAULT_TITLE)
      expect(l.pages).to eq([])
      expect(l.use_utc).to eq(false)
      expect(l.gchart_options).to eq({})
    end
  end

  describe "#page" do
    it "adds page constructed by block to pages" do
      layout.page "My Foo Page" do |p|
        p.pie "foo_widget", sensor: sensor_name
        p.line "bar_widget" do |w|
          w.sensor(sensor_name)
        end
      end
      l = layout.to_data
      expect(l.pages.size).to eq(1)
      p = l.pages.first
      expect(p.title).to eq("My Foo Page")
      expect(p.widgets.size).to eq(2)
      expect(p.widgets.first.title).to eq("foo_widget")
      expect(p.widgets.last.title).to eq("bar_widget")
    end
  end

  describe "#title" do
    it "sets layout title" do
      layout.title "Foo Title"
      expect(layout.to_data.title).to eq('Foo Title')
    end
  end

  describe "#use_utc" do
    it "sets use_utc" do
      layout.use_utc false
      expect(layout.to_data.use_utc).to eq(false)
    end
  end

  describe "#gchart_options" do
    it "sets gchart_options" do
      layout.gchart_options({b: 1})
      expect(layout.to_data.gchart_options).to eq({b: 1})
    end
  end

  describe "#to_data" do
    it "converts layout dsl data to Visualize::Layout" do
      expect(layout.to_data).to be_kind_of(PulseMeter::Visualize::Layout)
    end
  end
end

