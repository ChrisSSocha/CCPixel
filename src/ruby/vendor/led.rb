require 'logger'

class LED

  @@logger = Logger.new(STDOUT)

  def initialize(vendor)
    @led = vendor
    @led.open
  end

  def fade_to(end_color, frames=20, sleep=0.05)
    start_color = @led.color
    opacity = 100
    frame = opacity/frames
    (0..frames).each do
      retry_operation {
        opacity -= frame
        @led.color = start_color.mix_with(end_color, opacity)
        sleep sleep
      }
    end
  end

  def off
    @led.off
  end

  private

    def retry_operation(&block)
      attempts = 0
      while attempts < 5
        attempts += 1
        begin
          block.yield
          break
        rescue
          @@logger.debug("Failed USB operation, retrying...")
          if attempts == 5
            raise
          end
        end
      end
    end
end