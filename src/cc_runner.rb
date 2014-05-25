require 'optparse'

require_relative 'cc_input'
require_relative 'cc_parser'
require_relative 'cc_output'
require_relative 'cc_pixel'
require_relative 'cc_config'
require_relative 'model/configuration'

config_file = nil
OptionParser.new do |opts|
  opts.banner = "Usage: cc_runner.rb [options]"

  opts.on('-c', '--config DIR', 'Config directory') do |v|
    config_file = v
  end
end.parse!

if config_file.nil?
  config_file = "./config.yml"
end

config = Configuration.load_yaml(File.new(config_file))

if config.useAuth?
  input = CCInput.new(config.getUrl(), config.getUsername(), config.getPassword)
else
  input = CCInput.new(config.getUrl())
end

parser = CCParser.new(input)

output = CCOutput.new
ccPixel = CCPixel.new(output)


Signal.trap("INT") do
  output.off!
  abort "Shutting down..."
end

while true

  ccPixel.process(parser.getProjects())

  sleep config.getSleepTime()

end
