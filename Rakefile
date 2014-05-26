#!/usr/bin/env rake
require 'bundler/gem_tasks'
require 'coffee-script'
require 'listen'
require 'rspec/core/rake_task'
require 'sprockets'
require 'tilt'
require 'yard'
require 'yard/rake/yardoc_task'

RSpec::Core::RakeTask.new(:spec)

YARD::Rake::YardocTask.new(:yard)

ROOT = File.dirname(__FILE__)

task :default => :spec

namespace :coffee do
  COFFEE_PATH = "#{ROOT}/lib/pulse_meter/visualize/coffee"

  def compile_js
    puts "Compiling application.js..."

    Tilt::CoffeeScriptTemplate.default_bare = true
    env = Sprockets::Environment.new
    env.append_path COFFEE_PATH
    data = env['application.coffee']
    open("#{ROOT}/lib/pulse_meter/visualize/public/js/application.js", "w").write(data)

    puts "application.js compiled."
  end

  desc "Compile coffee to js"
  task :compile do
    compile_js
  end

  desc "Watch coffee files and recomplile them immediately"
  task :watch do
    puts "Watching '#{COFFEE_PATH}'..."

    listener = Listen.to(COFFEE_PATH) do |modified, added, removed|
      puts "Modified: #{modified}" unless modified.empty?
      puts "Added: #{added}" unless added.empty?
      puts "Removed: #{removed}" unless removed.empty?
      compile_js
    end

    listener.start
    sleep
  end
end

namespace :yard do
  desc "Open doc index in a browser"
  task :open do
    system 'open', "#{ROOT}/doc/index.html"
  end
end

