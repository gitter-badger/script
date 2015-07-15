#!/usr/bin/env python
# narrative.py
# Author: Andy Bettisworth
# License: LGPLv3, Apache, MIT, BSD, your choice
# Created At: 2015 0423 004655
# Modified At: 2015 0423 004655
# Description: Narrative Clip from the command-line

## > flush all photos off device
## > copy all photos off device


### Sandbox

## $ lsusb
#=> Bus 001 Device 019: ID f0f0:1337

## $ lsusb -d f0f0:1337
#=> Bus 001 Device 019: ID f0f0:1337

## $ lsusb -d f0f0:1337 | cut -f2 -d' '
#=> 001

## /dev/bus/usb/001/019


### Links

# https://learn.adafruit.com/narrative-clip-teardown/inside-the-narrative-clip
# https://plus.google.com/+WaiHoLi/posts/EBazH7gbWL6
# https://github.com/ruins/offline-narrative
# https://github.com/mrquincle/memoto
# http://www.libusb.org/


# libusb wrapper mruby-libusb for mruby?
# MRI ruby has 'libusb' gem

# $ sudo aptitude install libusb-1.0-0-dev
# $ gem install libusb

## Example

# require "libusb"

# usb = LIBUSB::Context.new
# device = usb.devices(:idVendor => 0x04b4, :idProduct => 0x8613).first
# device.open_interface(0) do |handle|
#   handle.control_transfer(:bmRequestType => 0x40, :bRequest => 0xa0, :wValue => 0xe600, :wIndex => 0x0000, :dataOut => 1.chr)
# end


### NarrativeClip “byte” instructions

# detach kernel driver
# open the device to get handle
# USB property "bmRequest" prepares device for communication
# close handle when done


### Debug in IRB

# $ irb
# $ require 'libusb'


### Probe a Narrative Clip

# $ lsusb -vvv -d f0f0:1337

#=> Bus 001 Device 024: ID f0f0:1337
#=> Device Descriptor:
#=>   bLength                18
#=>   bDescriptorType         1
#=>   bcdUSB               2.00
#=>   bDeviceClass          255 Vendor Specific Class
#=>   bDeviceSubClass         0
#=>   bDeviceProtocol         0
#=>   bMaxPacketSize0        64
#=>   idVendor           0xf0f0
#=>   idProduct          0x1337
#=>   bcdDevice            1.08
#=>   iManufacturer           1 Narrative
#=>   iProduct                2 Narrative Clip
#=>   iSerial                 3 45010053454d303847900b0ca7a251f7
#=>   bNumConfigurations      1
#=>   Configuration Descriptor:
#=>     bLength                 9
#=>     bDescriptorType         2
#=>     wTotalLength           32
#=>     bNumInterfaces          1
#=>     bConfigurationValue     1
#=>     iConfiguration          4 Narrative USB #1
#=>     bmAttributes         0xc0
#=>       Self Powered
#=>     MaxPower              450mA
#=>     Interface Descriptor:
#=>       bLength                 9
#=>       bDescriptorType         4
#=>       bInterfaceNumber        0
#=>       bAlternateSetting       0
#=>       bNumEndpoints           2
#=>       bInterfaceClass       255 Vendor Specific Class
#=>       bInterfaceSubClass      0
#=>       bInterfaceProtocol      0
#=>       iInterface              5 Narrative Clip
#=>       Endpoint Descriptor:
#=>         bLength                 7
#=>         bDescriptorType         5
#=>         bEndpointAddress     0x81  EP 1 IN
#=>         bmAttributes            2
#=>           Transfer Type            Bulk
#=>           Synch Type               None
#=>           Usage Type               Data
#=>         wMaxPacketSize     0x0200  1x 512 bytes
#=>         bInterval               0
#=>       Endpoint Descriptor:
#=>         bLength                 7
#=>         bDescriptorType         5
#=>         bEndpointAddress     0x02  EP 2 OUT
#=>         bmAttributes            2
#=>           Transfer Type            Bulk
#=>           Synch Type               None
#=>           Usage Type               Data
#=>         wMaxPacketSize     0x0200  1x 512 bytes
#=>         bInterval               1
#=> Device Qualifier (for other device speed):
#=>   bLength                10
#=>   bDescriptorType         6
#=>   bcdUSB               2.00
#=>   bDeviceClass          255 Vendor Specific Class
#=>   bDeviceSubClass         0
#=>   bDeviceProtocol         0
#=>   bMaxPacketSize0        64
#=>   bNumConfigurations      1
#=> Device Status:     0x0001
#=>   Self Powered

## Notes

# There are two endpoints. Both are of the bulk type.
# Endpoint 0x81 is used to obtain files from the device.


### Get Images

# The files are stored in the folder /mnt/storage.
# There will be .jpg files and .meta.json files.

# >


### GPS

# I understand that some people are really anxious in getting the GPS working properly.
# There is a file /etc/init.d/S56aclys which inserts the kernel module
# /lib/modules/2.6.39+/extra/aclys_gpio.ko.
# The aclys_snap file in /bin is quite small, just 15kB.
# So, there is no encryption done or things like that.
# Those snap files you can retrieve from the device is
# probably just raw data from the sensor.
