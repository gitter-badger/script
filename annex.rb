#!/usr/bin/ruby -w
# annex.rb
# Author: Andy Bettisworth
# Description: Sync files with Village USB

class Annex
  HOME            = ENV['HOME']
  ANNEX_SYNC_PATH = "/media/Village/preseed/seed/.sync"
  LOCAL_SYNC_PATH = "#{HOME}/.sync"
  RBENV_PATH      = "#{HOME}/.rbenv"
  CANVAS_PATH     = "#{LOCAL_SYNC_PATH}/.canvas"
  SCRIPT_PATH     = "#{LOCAL_SYNC_PATH}/.script"
  TEMPLATE_PATH   = "#{LOCAL_SYNC_PATH}/.template"
  APPLICATIONS    = [
    'developer_training',
    'accreu'
  ]
  GEMS = [
    'scrapyard',
    'tribe_triage',
    'phantom_assembly',
    'tandem_feet',
    'collective_vibration'
  ]

  def start
    raise 'Village USB is required.' unless File.exist?(ANNEX_SYNC_PATH)

    sync RBENV_PATH
    sync CANVAS_PATH
    sync SCRIPT_PATH
    sync TEMPLATE_PATH

    APPLICATIONS.each do |app|
      sync "#{LOCAL_SYNC_PATH}/.app/#{app}"
    end

    GEMS.each do |g|
      sync "#{LOCAL_SYNC_PATH}/.gem/#{g}"
    end
  end

  private

  def sync(path)
      unless File.exist?(path)
        puts "WARNING: path not found"
        puts "#{path}"
        return
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
      git checkout annex;
    CMD
  end
end

# EXEC the annex sync
update = Annex.new
update.start
