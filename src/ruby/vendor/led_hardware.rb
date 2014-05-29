require 'logger'

require_relative '../exceptions/hardware_io_error'
require_relative '../exceptions/hardware_not_found_error'

class LEDHardware

  @@logger = Logger.new(STDOUT)

  def initialize(vendor)
    @device = vendor

    rescue_from_hardware_error {
      @device.open
    }
  end

  def fade_to(end_color, frames=20, sleep=0.05)
    rescue_from_hardware_error {
      start_color = @device.color
      opacity = 100
      frame = opacity/frames
      (0..frames).each do
        retry_operation {
          opacity -= frame
          @device.color = start_color.mix_with(end_color, opacity)
          sleep sleep
        }
      end
    }
  end

  def off
    rescue_from_hardware_error {
      @device.off
    }
  end

  private

    def retry_operation(&block)
      attempts = 0
      while attempts < 5
        attempts += 1
        begin
          block.yield
          break
        rescue LIBUSB::ERROR_IO, LIBUSB::ERROR_PIPE => e
          @@logger.debug("LIBUSB Error '#{e.inspect}'. Attempt #{attempts} of 5...")
          if attempts == 5
            @@logger.debug("LIBUSB Error '#{e.inspect}'. Retried max number of times")
            raise HardwareIOError, e.inspect
          end
        end
      end
    end

    def rescue_from_hardware_error(&block)
      begin
        block.yield
      rescue LIBUSB::ERROR_NO_DEVICE, NoMethodError => e
        @@logger.debug("Problem opening LED Driver: " + e.inspect)
        raise HardwareNotFoundError, 'Problem opening LED Driver'
      end
    end

end