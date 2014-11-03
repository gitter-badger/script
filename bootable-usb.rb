#!/usr/bin/env ruby -w
# bootable-usb.rb
# Author: Andy Bettisworth
# Description: Used to create a bootable USB with target *nix ISO flavour

class BootableUSB
  def initialize(device)
    raise "Error: No such device located at '#{device}'" unless Kernel.test('b', device)
  end

  def build(iso)
    raise "Error: No such iso file located at '#{iso}'" unless File.extname(iso) == '.iso'

    # > partition tablespace
    # /dev/sdX1 ntfs Village    ~80% GiB boot
    # /dev/sdX2 ext4 casper-rw  ~20% GiB

    # > extract iso
    # sudo mkdir /mnt/ubuntu
    # sudo mount -o loop ubuntu.iso /mnt/ubuntu
    # rsync -aP /mnt/ubuntu/* /media/raist/Village
    # sudo unlink /media/raist/Village/ubuntu
    # rm /media/raist/Village/boot/grub/loopback.cfg
  end

  private

  def print_partition_table(device)
    puts "Current device partition table: "
    table = `sudo fdisk -l #{device}`
    puts table
  end

  def confirm
    puts "This operation will wipe the target device. Continue? (y|n)"
    answer = gets until answer
    puts answer
  end
end

require 'optparse'

option_parser = OptionParser.new do |opts|
  opts.banner = "USAGE: bootable-usb DEVICE ISO"
end
option_parser.parse!

if __FILE__ == $0
  if ARGV.count > 1
    generator = BootableUSB.new(ARGV[0])
    generator.build(ARGV[1])
  else
    puts option_parser
  end
end
