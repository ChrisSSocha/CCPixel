require_relative 'vendor/led'
require_relative 'vendor/blinkstick/blinkstick'

require 'color'

class BuildMonitor

  module Color
    RED = ::Color::RGB.new(20,0,0)
    GREEN = ::Color::RGB.new(0,20,0)
    YELLOW = ::Color::RGB.new(40,40,0)
  end

  def initialize
    @led = LED.new(BlinkStick.new)
  end

  def fail
    run {
      @led.fade_to(Color::RED)
    }
  end

  def success
    run {
      @led.fade_to(Color::GREEN)
    }
  end

  def fail_building
    run_loop {
      @led.fade_to(Color::RED)
      @led.fade_to(Color::YELLOW)
    }
  end

  def success_building
    run_loop {
      @led.fade_to(Color::GREEN)
      @led.fade_to(Color::YELLOW)
    }
  end

  def off
    run {
      @led.off
    }
  end

  def off!
    off()
    @thread.join()
  end

  private

    def run_loop(&block)
      run {
        while @running
          block.yield
        end
      }
    end

    def run(&block)
      @running = false
      @thread.join if @thread
      @running = true
      @thread = Thread.new &block
    end

end