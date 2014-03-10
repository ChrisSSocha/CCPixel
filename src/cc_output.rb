require_relative 'vendor/blinkstick'
require 'color'

class CCOutput

  def initialize
    @blinkStick = BlinkStick.new
    @blinkStick.open()
  end

  def fail
    @blinkStick.color = Color::RGB::Red
  end

  def success
    @blinkStick.color = Color::RGB::Green
  end

  def fail_building
    @blinkStick.color = Color::RGB::Yellow
  end

  def success_building
    @blinkStick.color = Color::RGB::Yellow
  end

end