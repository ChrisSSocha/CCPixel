require_relative 'cc_input'
require_relative 'cc_parser'
require_relative 'cc_output'
require_relative 'cc_pixel'

begin

  input = CCInput.new("http://localhost:4567")
  parser = CCParser.new(input)

  output = CCOutput.new
  ccPixel = CCPixel.new(output)

  while true

    ccPixel.process(parser.getProjects())

    sleep 10

  end
rescue SystemExit, Interrupt
  output.off()
end