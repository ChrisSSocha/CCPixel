require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new(:spec)

task :default => [:run]

task :test => :spec

task :run do
  ruby "src/ruby/cc_pixel.rb"
end