#!/usr/bin/ruby -w
# annex.rb
# Author: Andy Bettisworth
# Description: Sync files with Annex
# Sync all: [.script, .canvas, .template, .rbenv]
# Sync some: [.app, .gem]

require 'optparse'

class Annex
  HOME = ENV['HOME']
  SYNC = "#{ENV['HOME']}/.sync"
  ANNEX_PATH = "/media/Village/preseed/seed/.sync"
  SYNC_PATHS = [
    "#{HOME}/.rbenv",
    "#{SYNC}/.canvas",
    "#{SYNC}/.script",
    "#{SYNC}/.template",
    "#{SYNC}/.app/accreu",
    "#{SYNC}/.gem/tribe_triage",
    "#{SYNC}/.gem/collective_vibration",
    "#{SYNC}/.gem/phantom_assembly",
    "#{SYNC}/.gem/tandem_feet"
  ]

  def sync
    raise 'WARNING: Annex not found.' unless File.exist?(ANNEX_PATH)

    SYNC_PATHS.each do |path|
      unless File.exist?(path)
        puts "WARNING: path not found"
        puts "#{path}"
        next
      end
      commit_local(path)
      sync_upstream(path)
    end
  end

  private

  def commit_local(path)
    system <<-CMD
      cd #{path};
      git checkout annex;
      git add -A;
      git commit -m "annex-#{Time.now.strftime('%Y%m%d%H%M%S')}";
    CMD
  end

  def sync_upstream(path)
    system <<-CMD
      cd #{path};
      git checkout master;
      git pull origin master;
      git checkout annex;
      git rebase master;
      git checkout master;
      git merge annex;
      git push origin master;
    CMD
  end
end

# Usage
update = Annex.new
update.sync
