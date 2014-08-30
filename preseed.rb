#!/usr/bin/ruby -w
# preseed.rb
# Author: Andy Bettisworth
# Description: Sync local preseed with latest version from USB Village

require 'fileutils'

class Preseed
  USB_SYNC = "/media/#{ENV['USER']}/Village/preseed/seed-install/.sync"
  USB_PRESEED_SEED = "#{USB_SYNC}/.preseed.git"
  LOCAL_SYNC = "#{ENV['HOME']}/.sync"
  LOCAL_PRESEED_SEED = "#{LOCAL_SYNC}/.preseed/seed-install/.sync/.preseed.git"

  def start
    require_annex_usb
    require_usb_repo
    sync_preseed
  end

  private

  def require_annex_usb
    raise 'USB_NOT_FOUND!' unless File.exist?(USB_SYNC)
  end

  def require_usb_repo
    raise 'USB_PRESEED_NOT_FOUND!' unless File.exist?(USB_PRESEED_SEED)
  end

  def sync_preseed
    remove_local_version
    copy_usb_version
  end

  def remove_local_version
    `sudo rm -r #{LOCAL_PRESEED_SEED}`
  end

  def copy_usb_version
    `cp -r #{USB_PRESEED_SEED} #{LOCAL_SYNC}`
  end
end

## USAGE
update =  Preseed.new
update.start
