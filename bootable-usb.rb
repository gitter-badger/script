#!/usr/bin/env ruby -w
# bootable-usb.rb
# Author: Andy Bettisworth
# Description: Used to create a bootable USB with target *nix ISO flavour

class BootableUSB
  attr_accessor :target_device
  attr_accessor :target_iso

  def build(device, iso, quiet=false)
    validate_args(device, iso)
    print_block_devices
    print_current_tablespace(device)
    exit unless confirm_operation
    puts 'continue'
  end

  private

  def validate_args(device, iso)
    raise "No such file at '#{device}'" unless File.exist?(device)
    raise "No such file at '#{iso}'" unless File.exist?(iso)
    raise "Not a block device '#{device}'" unless Kernel.test('b', device)
    raise "Not an ISO file '#{iso}'" unless File.extname(iso) == '.iso'
  end

  def print_block_devices
    puts ""
    puts `lsblk`
    puts ""
  end

  def print_current_tablespace(device)
    puts "Target device partition table: "
    puts `sudo fdisk -l #{device}`
    puts ""
  end

  def confirm_operation
    puts "This operation will completely wipe the device."
    puts "Are you sure you want to continue? (y|n)"
    answer = $stdin.gets until answer
    if /y/i.match(answer)
      return true
    else
      return false
    end
  end
end

if __FILE__ == $0
  require 'optparse'

  options = {}
  option_parser = OptionParser.new do |opts|
    opts.banner = "USAGE: bootable-usb DEVICE ISO"

    opts.on('-q', '--quiet', 'Quietly execute without log output') do
      options[:quiet] = true
    end
  end
  option_parser.parse!

  builder = BootableUSB.new

  unless ARGV.count > 1
    puts option_parser
    exit
  end

  if options[:quiet]
    builder.build(ARGV[0], ARGV[1], true)
    exit
  else
    builder.build(ARGV[0], ARGV[1])
    exit
  end

  puts option_parser
end
