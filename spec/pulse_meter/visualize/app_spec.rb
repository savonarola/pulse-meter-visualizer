require 'spec_helper'

describe PulseMeter::Visualize::App do
  include Rack::Test::Methods
  before(:each) do
    @layout = PulseMeter::Visualizer.draw do |l|
      l.title "Foo meters"
      l.page "Foo page" do
      end
    end
  end

  def app
    PulseMeter::Visualize::App.new(@layout)
  end
  
  it "responds to /" do
    get '/'
    expect(last_response).to be_ok
    expect(last_response.body).to include("Foo meters")
  end

  it "responds to /application.js" do
    get '/js/application.js'
    expect(last_response).to be_ok
  end
end
