require_relative 'cc_input'
require_relative 'cc_parser'
require_relative 'cc_output'
require_relative 'cc_pixel'
require_relative 'cc_config'

begin

  working_directory = Dir.getwd
  config_file = "#{working_directory}/config.yml"

  config = CCConfig.new(config_file)

  input = CCInput.new(config.getUrl())
  parser = CCParser.new(input)

  output = CCOutput.new
  ccPixel = CCPixel.new(output)

  while true

    ccPixel.process(parser.getProjects())

    sleep config.getSleepTime()

  end
rescue SystemExit, Interrupt
  output.off()
end