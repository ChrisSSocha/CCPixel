require 'color'

require_relative 'vendor/blinkstick'

class BuildMonitor

  module Color
    RED = ::Color::RGB.new(20,0,0)
    GREEN = ::Color::RGB.new(0,20,0)
    YELLOW = ::Color::RGB.new(20,20,0)
  end

  def initialize
    @blinkstick = BlinkStick.new
  end

  def fail
    run do
      @blinkstick.fade_to(Color::RED)
    end
  end

  def success
    run do
      @blinkstick.fade_to(Color::GREEN)
    end
  end

  def fail_building
    run_loop do
      @blinkstick.fade_to(Color::RED)
      @blinkstick.fade_to(Color::YELLOW)
    end
  end

  def success_building
    run_loop do
      @blinkstick.fade_to(Color::GREEN)
      @blinkstick.fade_to(Color::YELLOW)
    end
  end

  def off
    run do
      @blinkstick.off
    end
  end

  def off!
    off
    @thread.join
  end

  private

    def run_loop(&block)
      run do
        while @running
          block.yield
        end
      end
    end

    def run(&block)
      @running = false
      @thread.join if @thread
      @running = true
      @thread = Thread.new &block
    end

end