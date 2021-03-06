#
# Copyright (C) 2013 Arvydas Juskevicius, Agile Innovative Ltd.
# All Rights Reserved.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions
# are met:
#
# 1. Redistributions of source code must retain the above copyright
#    notice, this list of conditions and the following disclaimer.
#
# 2. Redistributions in binary form must reproduce the above copyright
#    notice, this list of conditions and the following disclaimer in the
#    documentation and/or other materials provided with the distribution.
#
# 3. The name of the author may not be used to endorse or promote products
#    derived from this software without specific prior written permission.
#
# THIS SOFTWARE IS PROVIDED BY THE AUTHOR "AS IS" AND ANY EXPRESS OR IMPLIED
# WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
# MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO
# EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
# EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT
# OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
# INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
# CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING
# IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY
# OF SUCH DAMAGE.
#

require 'libusb'
require 'color'

require_relative '../utils/logger'
require_relative '../exceptions/hardware_not_found_error'
require_relative '../exceptions/hardware_io_error'

class BlinkStick
  @@VENDOR_ID = 0X20A0
  @@PRODUCT_ID = 0x41E5

  def initialize(device = nil)
    usb ||= LIBUSB::Context.new

    if device
      @device = device
    else
      @device = usb.devices(:idVendor => @@VENDOR_ID, :idProduct => @@PRODUCT_ID).first
    end

    if @device.nil?
      $logger.debug('Problem opening LED Driver')
      raise HardwareNotFoundError, 'Problem opening LED Driver'
    end
  end

  def set_color(value)
    connect do |handle|
      handle.control_transfer(:bmRequestType => 0x20, :bRequest => 0x9, :wValue => 0x1, :wIndex => 0x0000, :dataOut => 1.chr + value.red.to_i.chr + value.green.to_i.chr + value.blue.to_i.chr)
    end
  end

  def get_color
    connect do |handle|
      result = handle.control_transfer(:bmRequestType => 0x80 | 0x20, :bRequest => 0x1, :wValue => 0x1, :wIndex => 0x0000, :dataIn => 4)
      return Color::RGB.new(result[1].ord, result[2].ord, result[3].ord)
    end
  end

  def fade_to(end_color, frames=20, sleep=0.05)
    start_color = get_color

    opacity = 100
    frame = opacity/frames
    (0..frames).each do
      opacity -= frame
      set_color start_color.mix_with(end_color, opacity)
      sleep sleep
    end

  end

  def off
    set_color Color::RGB.new(0, 0, 0)
  end

  private

    def connect
      begin
        @device.open do |handle|
          attempts = 0
          while attempts < 5
            attempts += 1
            begin
              return yield handle
            rescue => e
              $logger.debug("LIBUSB Error '#{e.inspect}'. Attempt #{attempts} of 5...")
              if attempts == 5
                $logger.debug("LIBUSB Error '#{e.inspect}'. Retried max number of times")
                raise HardwareIOError, e.inspect
              else
                exponential_backoff = (2 ** attempts)/100.0
                sleep exponential_backoff
              end
            end
          end
        end
      rescue LIBUSB::ERROR_NO_DEVICE => e
        $logger.debug('Problem opening LED Driver: ' + e.inspect)
        raise HardwareNotFoundError, 'Problem opening LED Driver'
      end

    end

end