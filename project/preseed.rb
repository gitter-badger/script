#!/usr/bin/ruby -w
# preseed.rb
# Author: Andy Bettisworth
# Description: Sync local preseed with latest version from USB Village

require 'fileutils'
require 'optparse'

class Preseed
  PRESEED_DIR  = "/media/#{ENV['USER']}/Village/preseed"
  USB_PRESEED  = "#{PRESEED_DIR}/.seed-install/.sync"
  SYNC_CONFIG  = "#{PRESEED_DIR}/.seed-config"
  SYNC_INSTALL = "#{PRESEED_DIR}/.seed-install"
  SYNC_MEDIA   = "#{PRESEED_DIR}/seed-media"
  LOCAL_SYNC   = "#{ENV['HOME']}/.sync/.preseed/seed-install/.sync"
  REPOS        = [
    ".app",
    ".canvas.git",
    ".gem",
    ".preseed.git",
    ".rbenv.git",
    ".script.git",
    ".template.git",
    ".todo.git"
  ]

  def initialize
    require_usb
  end

  def start
    sync_preseed
  end

  private

  def require_usb
    raise 'Village USB not found!' unless File.exist?(USB_PRESEED)
  end

  def sync_preseed
    REPOS.each do |repository|
      remove_local_version(repository)
      copy_usb_version(repository)
    end
  end

  def remove_local_version(repository)
    puts ""
    puts "REMOVING #{repository} locally"
    puts ""
    system("sudo rm --recursive --verbose #{LOCAL_SYNC}/#{repository}")
  end

  def copy_usb_version(repository)
    puts ""
    puts "COPYING #{repository} from Village USB"
    puts ""
    system("cp --recursive --verbose #{USB_SYNC}/#{repository} #{LOCAL_SYNC}")
  end
end

if __FILE__ == $0
  options = {}
  option_parser = OptionParser.new do |opts|
    opts.banner = "Usage: preseed [option]"

    opts.on('--sync', 'Sync local files with those available on USB [config install media]') do
      options[:sync] = true
    end

    opts.on('--seed', 'Seed local files if USB has [install] preseed') do
      options[:seed] = true
    end
  end
  option_parser.parse!

  p =  Preseed.new

  if options[:sync]
    # p.sync
  elsif options[:seed]
    # p.seed
  else
    puts option_parser
  end
end
