require 'optparse'
require 'logger'

require_relative 'pipeline_web_resource'
require_relative 'pipeline_xml_parser'
require_relative 'build_monitor'
require_relative 'build_processor'
require_relative 'model/configuration'
require_relative 'utils/scheduler'

$LOGGER = Logger.new(STDOUT)
$LOGGER.sev_threshold = Logger::INFO

class CCPixel

  def initialize(scheduler)
    @scheduler = scheduler
  end

  def run(config_file)
    $LOGGER.info('Started CCPixel')

    config = load_config(config_file)

    input = PipelineWebResource.new(config.get_url, config.get_username, config.get_password)
    parser = PipelineXMLParser.new
    output = BuildMonitor.new
    build_processor = BuildProcessor.new(input, parser, output)

    build_processor.run
    @scheduler.every config.get_sleep_time do
      build_processor.run
    end

    @scheduler.join

    $LOGGER.info('Shutting down...')
    output.off!

  end

  private

    def load_config(config_file)
      config = Configuration.load_yaml(File.new(config_file))
      $LOGGER.debug('loaded configuration from ' + config_file)
      config
    end

end

def get_config_file
  config_file = './config.yml'

  OptionParser.new do |opts|
    opts.banner = 'Usage: cc_pixel.rb [options]'

    opts.on('-c', '--config DIR', 'Config directory') do |v|
      config_file = v
    end

    opts.on('-d', '--debug', 'Set logger to DEGUB') do |v|
      $LOGGER.sev_threshold = Logger::DEBUG
    end
    
  end.parse!

  return config_file
end


begin
  scheduler = Scheduler.new

  Signal.trap('INT') do
    scheduler.shutdown
  end

  ccPixel = CCPixel.new(scheduler)
  ccPixel.run(get_config_file())
rescue => e
  $LOGGER.fatal('Fatal problem: ' + e.inspect);
  $LOGGER.debug(e.backtrace)
  $LOGGER.fatal('Please re-run with debug flag enabled and file bug report.')
  abort
end