#!/usr/bin/env ruby -w
# bootable-usb.rb
# Author: Andy Bettisworth
# Description: Used to create a bootable USB with target *nix ISO flavour

class BootableUSB

  def build(device, iso, peristence=0, quiet=false)
    validate_files(device, iso)
    peristence = validate_pct(peristence)

    print_block_devices
    print_current_tablespace(device)
    exit unless confirm_operation

    ## > Partition Device
    # /dev/sdX1 ntfs Village    ~80% GiB boot
    # /dev/sdX2 ext4 casper-rw  ~20% GiB

    ## > Extract ISO
    # sudo mkdir /mnt/ubuntu
    # sudo mount -o loop ubuntu.iso /mnt/ubuntu

    ## > Copy ISO to Device
    # rsync -aP /mnt/ubuntu/* /media/raist/Village
    # sudo unlink /media/raist/Village/ubuntu

    ## > Setup GRUB bootloader
    # rm /media/raist/Village/boot/grub/loopback.cfg
    # cp ~/.sync/.preseed/grub.cfg /media/raist/Village/boot/grub/grub.cfg
    # sudo grub-install --no-floppy --root-directory=/media/raist/Village/ /dev/sdX
  end

  private

  def validate_files(device, iso, peristence)
    raise "No such file at '#{device}'" unless File.exist?(device)
    raise "No such file at '#{iso}'" unless File.exist?(iso)
    raise "Not a block device '#{device}'" unless Kernel.test('b', device)
    raise "Not an ISO file '#{iso}'" unless File.extname(iso) == '.iso'
  end

  def validate_pct(peristence)
    peristence = 0 unless is_numeric?(peristence)
    peristence
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

  def is_numeric?(s)
    !!Float(s) rescue false
  end
end

if __FILE__ == $0
  require 'optparse'

  options = {}
  option_parser = OptionParser.new do |opts|
    opts.banner = "USAGE: bootable-usb DEVICE ISO"

    opts.on('-p PERCENT', '--persistent PERCENT', 'Include a persistent partition') do |pct|
      options[:persistence] = pct
    end

    opts.on('-q', '--quiet', 'Quietly execute without log output') do
      options[:quiet] = true
    end
  end
  option_parser.parse!

  builder = BootableUSB.new

  unless ARGV.count > 1
    puts option_parser
    exit
  else
    options[:persistence] ? pct = options[:persistence] : pct = 0
    options[:quiet] ? quiet = true : quiet = false

    builder.build(ARGV[0], ARGV[1], pct, quiet)
    exit
  end
end
