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

    ## > handle persistence percent
    `echo -e "o\nn\np\n1\n\n\nw" | sudo fdisk #{device}`
    # /dev/sdX1 ntfs Village    ~80% GiB boot
    # /dev/sdX2 ext4 casper-rw  ~20% GiB

    ## > format partitions
    `sudo mkfs --type ntfs #{device}1`
    # `sudo mkfs --type ext4 #{device}2`

    ## > label partitions
    `sudo ntfslabel #{device}1 Village`
    # `sudo e2label #{device}2 casper-rw`

    ## > Extract ISO
    `sudo rm -r /mnt/tmpiso`
    `sudo mkdir /mnt/tmpiso`
    `sudo mount -o loop #{iso} /mnt/tmpiso`

    ## > Copy ISO to Device
    ## En handle auto reattch device
    `rsync -aP /mnt/tmpiso/* /media/raist/Village`
    `sudo unlink /media/raist/Village/ubuntu`
    `sudo rm -r /mnt/tmpiso`

    ## > Setup GRUB bootloader
    `rm /media/raist/Village/boot/grub/loopback.cfg`
    `cp ~/.sync/.preseed/grub.cfg /media/raist/Village/boot/grub/grub.cfg`
    `sudo grub-install --no-floppy --root-directory=/media/raist/Village/ #{device}`
  end

  private

  def validate_files(device, iso, peristence)
    raise "No such file at '#{device}'" unless File.exist?(device)
    raise "No such file at '#{iso}'" unless File.exist?(iso)
    # > ensure it is not SDXY just SDX
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
