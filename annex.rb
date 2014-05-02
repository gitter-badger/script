#!/usr/bin/ruby -w
# annex.rb
# Author: Andy Bettisworth
# Description: Sync files with Annex

require 'optparse'

class Annex
  HOME = ENV['HOME']
  LOCAL_SYNC = "#{ENV['HOME']}/.sync"
  ANNEX_SYNC = "/media/Village/preseed/seed/.sync"
  SYNC_PATHS = [
    "#{HOME}/.rbenv",
    "#{LOCAL_SYNC}/.canvas",
    "#{LOCAL_SYNC}/.script",
    "#{LOCAL_SYNC}/.template"
  ]
    # "#{LOCAL_SYNC}/.app/accreu",
    # "#{LOCAL_SYNC}/.gem/tribe_triage",
    # "#{LOCAL_SYNC}/.gem/collective_vibration",
    # "#{LOCAL_SYNC}/.gem/phantom_assembly",
    # "#{LOCAL_SYNC}/.gem/tandem_feet"

  def sync
    raise 'WARNING: Annex not found.' unless File.exist?(ANNEX_SYNC)

    SYNC_PATHS.each do |path|
      unless File.exist?(path)
        puts "WARNING: path not found"
        puts "#{path}"
        next
      end
      puts ""
      puts "  #{path}"
      puts ""
      puts " > commit local changes"
      commit_local(path)
      puts ""

      puts " > sync upstream changes"
      sync_upstream(path)
      puts ""
      puts ""
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
