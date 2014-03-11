require_relative 'vendor/blinkstick'
require 'color'

class CCOutput

  module Color
    RED = ::Color::RGB.new(20,0,0)
    GREEN = ::Color::RGB.new(0,20,0)
    YELLOW = ::Color::RGB.new(40,40,0)
  end

  def initialize
    @blinkStick = BlinkStick.new
    @blinkStick.open()
  end

  def fail
    run {
      @blinkStick.fade_to(Color::RED)
    }
  end

  def success
    run {
      @blinkStick.fade_to(Color::GREEN)
    }
  end

  def fail_building
    run {
      while @running
        @blinkStick.fade_to(Color::RED)
        @blinkStick.fade_to(Color::YELLOW)
      end
    }
  end

  def success_building
    run {
      while @running
        @blinkStick.fade_to(Color::GREEN)
        @blinkStick.fade_to(Color::YELLOW)
      end
    }
  end

  def off
    @blinkStick.off
  end

  private

    def run(&block)
      @running = false
      @thread.join if @thread
      @thread.exit if @thread
      @running = true
      @thread = Thread.new &block
    end

end