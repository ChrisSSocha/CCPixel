require_relative 'cc_input'
require_relative 'cc_parser'
require_relative 'cc_output'
require_relative 'cc_pixel'
require_relative 'cc_config'
require_relative 'model/configuration'

begin

  working_directory = Dir.getwd
  config_file = "#{working_directory}/config.yml"

  file = File.new(config_file)

  config = Configuration.load_yaml(file)

  if config.useAuth?
    input = CCInput.new(config.getUrl(), config.getUsername(), config.getPassword)
  else
    input = CCInput.new(config.getUrl())
  end

  parser = CCParser.new(input)

  output = CCOutput.new
  ccPixel = CCPixel.new(output)

  while true

    ccPixel.process(parser.getProjects())

    sleep config.getSleepTime()

  end
rescue SystemExit, Interrupt
  output.off!()
end