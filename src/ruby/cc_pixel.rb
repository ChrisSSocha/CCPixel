require 'optparse'
require 'rufus-scheduler'
require 'logger'

require_relative 'pipeline_web_resource'
require_relative 'pipeline_xml_parser'
require_relative 'build_monitor'
require_relative 'build_processor'
require_relative 'model/configuration'

class CCPixel
  @@logger = Logger.new(STDOUT)

  def self.run(config_file)
    @@logger.info('Started CCPixel')

    config = load_config(config_file)

    input = PipelineWebResource.new(config.get_url, config.get_username, config.get_password)
    parser = PipelineXMLParser.new
    output = BuildMonitor.new
    cc_pixel = BuildProcessor.new(input, parser, output)

    schedule_build_monitor(cc_pixel, config)

    @@logger.info('Shutting down...')
    output.off!

  end

  private

    def self.load_config(config_file)
      config = Configuration.load_yaml(File.new(config_file))
      @@logger.debug('loaded configuration from ' + config_file)
      config
    end

    def self.schedule_build_monitor(cc_pixel, config)
      scheduler = Rufus::Scheduler.new

      Signal.trap('INT') do
        scheduler.shutdown
      end

      cc_pixel.run
      scheduler.every config.get_sleep_time do
        cc_pixel.run
      end

      scheduler.join
    end

end

config_file = nil
OptionParser.new do |opts|
  opts.banner = 'Usage: cc_pixel.rb [options]'

  opts.on('-c', '--config DIR', 'Config directory') do |v|
    config_file = v
  end
end.parse!

if config_file.nil?
  config_file = './config.yml'
end

CCPixel.run(config_file)