require 'optparse'

require_relative 'pipeline_web_resource'
require_relative 'pipeline_xml_parser'
require_relative 'build_monitor'
require_relative 'build_processor'
require_relative 'model/configuration'

config_file = nil
OptionParser.new do |opts|
  opts.banner = "Usage: cc_pixel.rb [options]"

  opts.on('-c', '--config DIR', 'Config directory') do |v|
    config_file = v
  end
end.parse!

if config_file.nil?
  config_file = "./config.yml"
end

config = Configuration.load_yaml(File.new(config_file))
input = PipelineWebResource.new(config.get_url, config.get_username, config.get_password)
parser = PipelineXMLParser.new
output = BuildMonitor.new

cc_pixel = BuildProcessor.new(input, parser, output)

Signal.trap("INT") do
  output.off!
  abort "Shutting down..."
end

while true

  cc_pixel.run

  sleep config.get_sleep_time

end