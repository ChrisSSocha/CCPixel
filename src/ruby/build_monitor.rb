require_relative 'vendor/blinkstick'
require 'color'

class BuildMonitor

  module Color
    RED = ::Color::RGB.new(20,0,0)
    GREEN = ::Color::RGB.new(0,20,0)
    YELLOW = ::Color::RGB.new(40,40,0)
  end

  def initialize
    @blink_stick = BlinkStick.new
    @blink_stick.open
  end

  def fail
    run {
      @blink_stick.fade_to(Color::RED)
    }
  end

  def success
    run {
      @blink_stick.fade_to(Color::GREEN)
    }
  end

  def fail_building
    run_loop {
      @blink_stick.fade_to(Color::RED)
      @blink_stick.fade_to(Color::YELLOW)
    }
  end

  def success_building
    run_loop {
      @blink_stick.fade_to(Color::GREEN)
      @blink_stick.fade_to(Color::YELLOW)
    }
  end

  def off
    run {
      @blink_stick.off
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