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

require "libusb"
require "color"

class BlinkStick
  @@VENDOR_ID = 0X20A0
  @@PRODUCT_ID = 0x41E5

  def open(device = nil)
    @@usb ||= LIBUSB::Context.new

    if (device)
      @device = device
    else
      @device = @@usb.devices(:idVendor => @@VENDOR_ID, :idProduct => @@PRODUCT_ID).first
    end

    @handle = @device.open
  end

  def self.find_all
    @@usb ||= LIBUSB::Context.new

    result = []

    @@usb.devices(:idVendor => @@VENDOR_ID, :idProduct => @@PRODUCT_ID).each { | device |
      b = BlinkStick.new
      b.open(device)

      result.push(b)
    }

    result
  end

  def self.find_by_serial(serial)
    @@usb ||= LIBUSB::Context.new

    @@usb.devices(:idVendor => @@VENDOR_ID, :idProduct => @@PRODUCT_ID).each { | device |
      if device.serial_number == serial
        b = BlinkStick.new
        b.open(device)
        return b
      end
    }

    nil
  end

  def color=(value)
    @handle.control_transfer(:bmRequestType => 0x20, :bRequest => 0x9, :wValue => 0x1, :wIndex => 0x0000, :dataOut => 1.chr + value.red.to_i.chr + value.green.to_i.chr + value.blue.to_i.chr)
  end

  def color
    result = @handle.control_transfer(:bmRequestType => 0x80 | 0x20, :bRequest => 0x1, :wValue => 0x1, :wIndex => 0x0000, :dataIn => 4)
    Color::RGB.new(result[1].ord, result[2].ord, result[3].ord)
  end

  def fade_to(end_color, frames=20, sleep=0.05)
    start_color = self.color()

    opacity = 100
    frame = opacity/frames
    for i in 0..frames
      opacity -= frame
      self.color = start_color.mix_with(end_color, opacity)
      sleep sleep
    end

  end

  def off
    self.color = Color::RGB.new(0, 0, 0)
  end

  def get_info_block(id)
    bytes = @handle.control_transfer(:bmRequestType => 0x80 | 0x20, :bRequest => 0x1, :wValue => id + 1, :wIndex => 0x0000, :dataIn => 33)

    result = ""
    for i in 1..(bytes.length-1)
      if i == "\x00"
        break
      end
      result += bytes[i]
    end

    result
  end

  def set_info_block(id, data)
    data = (id + 1).chr + data
    data = data + 0.chr while data.length < 33
    @handle.control_transfer(:bmRequestType => 0x20, :bRequest => 0x9, :wValue => id + 1, :wIndex => 0x0000, :dataOut => data)
  end

  def random_color
    r = Random.new
    self.color = Color::RGB.new(r.rand(255), r.rand(255), r.rand(255))
  end

  def serial
    @device.serial_number
  end

  def manufacturer
    @device.manufacturer
  end

  def description
    @device.product
  end

  def info_block1
    get_info_block(1)
  end

  def info_block1=(value)
    set_info_block(1, value)
  end

  def info_block2
    get_info_block(2)
  end

  def info_block2=(value)
    set_info_block(2, value)
  end
end
