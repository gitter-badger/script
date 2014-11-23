#!/usr/bin/ruby -w
# preseed.rb
# Author: Andy Bettisworth
# Description: Sync local preseed with latest version from USB Village

require 'fileutils'
require 'optparse'

class Preseed
  PRESEED_DIR  = "/media/#{ENV['USER']}/Village/preseed"
  SYNC_CONFIG  = "#{PRESEED_DIR}/.seed-config"
  SYNC_INSTALL = "#{PRESEED_DIR}/.seed-install"
  SYNC_MEDIA   = "#{PRESEED_DIR}/seed-media"
  LOCAL_SEED   = "#{ENV['HOME']}/.sync/.preseed/.seed-install/.sync"
  USB_SEED     = "#{PRESEED_DIR}/.seed-install/.sync"
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
    raise 'Elligible USB not found.' unless File.exist?(PRESEED_DIR)
  end

  def sync
    sync_with_remote(SYNC_CONFIG, 'origin')
    sync_with_remote(SYNC_INSTALL, 'origin')
  end

  def seed
    # > TODO
  end

  private

  def sync_preseed
    REPOS.each do |repository|
      remove_local_version(repository)
      copy_usb_version(repository)
    end
  end

  def remove_local_version(repository)
    puts "Removing local copy #{repository}..."
    system("sudo rm --recursive --verbose #{LOCAL_SYNC}/#{repository}")
  end

  def copy_usb_version(repository)
    puts "Copying USB version to local #{repository}..."
    system("cp --recursive --verbose #{USB_SYNC}/#{repository} #{LOCAL_SYNC}")
  end

  def sync_with_remote(repo_path, remote)
    raise "MissingBranch: No branch named 'master'" unless branch_exist?(repo_path, 'master')
    raise "MissingBranch: No branch named 'annex'" unless branch_exist?(repo_path, 'annex')
    system <<-CMD
      cd #{repo_path}
      git checkout master
      git merge annex
      git pull --no-edit #{remote} master
      git push #{remote} master
      git checkout annex
      git merge --no-edit master
    CMD
  end
end

if __FILE__ == $0
  options = {}
  option_parser = OptionParser.new do |opts|
    opts.banner = "Usage: preseed [option]"

    opts.on('--sync', 'Sync local preseeds with USB [config install]') do
      options[:sync] = true
    end

    opts.on('--seed-config', 'Add preseed [config] to USB') do
      options[:seed_config] = true
    end

    opts.on('--seed-install', 'Add preseed [install] to USB') do
      options[:seed_install] = true
    end

    opts.on('--seed-media', 'Add preseed [media] to USB') do
      options[:seed_media] = true
    end
  end
  option_parser.parse!

  p =  Preseed.new

  if options[:sync]
    p.sync
  elsif options[:seed]
    p.seed
  else
    puts option_parser
  end
end