require 'rspec/core/rake_task'
require_relative 'src/cc_runner'

RSpec::Core::RakeTask.new(:spec)

task :default => [:run]

task :test => :spec

task :run do
  ruby "src/cc_runner.rb"
end