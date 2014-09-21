#!/usr/bin/ruby -w
# preseed.rb
# Author: Andy Bettisworth
# Description: Sync local preseed with latest version from USB Village

require 'fileutils'

class Preseed
  USB_SYNC           = "/media/#{ENV['USER']}/Village/preseed/seed-install/.sync"
  USB_PRESEED_SEED   = "#{USB_SYNC}/.preseed.git"
  LOCAL_SYNC         = "#{ENV['HOME']}/.sync"
  LOCAL_PRESEED_SEED = "#{LOCAL_SYNC}/.preseed/seed-install/.sync/.preseed.git"

  REPOS = [
    ".app",
    ".canvas.git",
    ".gem",
    ".preseed.git",
    ".rbenv.git",
    ".script.git",
    ".template.git",
    ".todo.git"
  ]

  def start
    require_annex_usb
    require_usb_repo
    sync_preseed
  end

  private

  def require_annex_usb
    raise 'Village USB not found!' unless File.exist?(USB_SYNC)
  end

  def require_usb_repo
    raise 'Village USB missing sync/preseed.git repo!' unless File.exist?(USB_PRESEED_SEED)
  end

  def sync_preseed
    REPOS.each do |repository|
      puts repository
      # remove_local_version(repository)
      # copy_usb_version(repository)
    end
  end

  def remove_local_version
    # > abstract target
    `sudo rm --recursive --verbose #{LOCAL_PRESEED_SEED}`
  end

  def copy_usb_version
    # > abstract target
    `cp --recursive --verbose #{USB_PRESEED_SEED} #{LOCAL_PRESEED_SEED}`
  end
end

## USAGE
update =  Preseed.new
update.start
