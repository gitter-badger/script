#!/usr/bin/ruby -w
# preseed.rb
# Author: Andy Bettisworth
# Description: Sync local preseed with latest version from USB Village

require 'fileutils'

class Preseed
  USB_SYNC   = "/media/#{ENV['USER']}/Village/preseed/seed-install/.sync"
  LOCAL_SYNC = "#{ENV['HOME']}/.sync/.preseed/seed-install/.sync"
  REPOS      = [
    # ".app",
    # ".canvas.git",
    # ".gem",
    # ".preseed.git",
    # ".rbenv.git",
    # ".script.git",
    # ".template.git",
    ".todo.git"
  ]

  def start
    require_usb
    sync_preseed
  end

  private

  def require_usb
    raise 'Village USB not found!' unless File.exist?(USB_SYNC)
  end

  def sync_preseed
    REPOS.each do |repository|
      remove_local_version(repository)
      copy_usb_version(repository)
    end
  end

  def remove_local_version(repository)
    system("sudo rm --recursive --verbose #{LOCAL_SYNC}/#{repository}")
    puts ""
    puts "REMOVED #{repository} locally"
    puts ""
  end

  def copy_usb_version(repository)
    system("cp --recursive --verbose #{USB_SYNC}/#{repository} #{LOCAL_SYNC}")
    puts ""
    puts "COPIED #{repository} from Village USB"
    puts ""
  end
end

## USAGE
update =  Preseed.new
update.start
