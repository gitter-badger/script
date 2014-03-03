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
  ANNEX = "/media/Annex/preseed/seed/.sync"
  APPS = ['accreu', 'tribetriage']
  GEMS = ['tribe_triage','collective_vibration','phantom_assembly','tandem_feet']

  def sync
    raise 'Annex not found.' unless File.exist?(ANNEX)
    sync_all
    ensure_repositories
    sync_apps
    sync_gems
  end

  private

  def sync_all
    commit_local
    system <<-CMD
      echo 'syncing: CANVAS';
      cd #{SYNC}/.canvas;
      git pull origin master;
      git push origin master;
      echo '';
      echo 'syncing: SCRIPT';
      cd #{SYNC}/.script;
      git pull origin master;
      git push origin master;
      echo '';
      echo 'syncing: TEMPLATE';
      cd #{SYNC}/.template;
      git pull origin master;
      git push origin master;
      echo '';
      echo 'syncing: RBENV';
      cd #{HOME}/.rbenv;
      git pull origin master;
      git push origin master;
    CMD
  end

  def commit_local
    system <<-CMD
      echo 'commiting: CANVAS';
      cd #{SYNC}/.canvas;
      git add -u;
      git commit -m "annex-#{Time.now.strftime('%Y%m%d%H%M%S')}";
      echo '';
      echo 'commiting: SCRIPT';
      cd #{SYNC}/.script;
      git add -u;
      git commit -m "annex-#{Time.now.strftime('%Y%m%d%H%M%S')}";
      echo '';
      echo 'commiting: TEMPLATE';
      cd #{SYNC}/.template;
      git add -u;
      git commit -m "annex-#{Time.now.strftime('%Y%m%d%H%M%S')}";
      echo '';
      echo 'commiting: RBENV';
      cd #{HOME}/.rbenv;
      git add -u;
      git commit -m "annex-#{Time.now.strftime('%Y%m%d%H%M%S')}";
    CMD
  end

  def sync_apps
    APPS.each do |application|
      system <<-CMD
        echo '';
        echo "syncing APP: #{application}";
        cd #{SYNC}/.app/#{application};
        git add -u;
        git commit -m "annex-#{Time.now.strftime('%Y%m%d%H%M%S')}";
        git pull origin master;
        git push origin master;
      CMD
    end
  end

  def sync_gems
    GEMS.each do |gem_project|
      system <<-CMD
        echo '';
        echo "syncing GEM: #{gem_project}";
        cd #{SYNC}/.gem/#{gem_project};
        git add -u;
        git commit -m "annex-#{Time.now.strftime('%Y%m%d%H%M%S')}";
        git pull origin master;
        git push origin master;
      CMD
    end
  end

  def ensure_repositories
    APPS.each do |application|
      unless File.exist?("#{SYNC}/.app/#{application}")
        Dir.mkdir("#{SYNC}/.app/#{application}")
        system <<-CMD
          cd #{SYNC}/.app/#{application};
          git clone #{ANNEX}/.app/#{application}.git;
        CMD
      end
    end
    GEMS.each do |gem_project|
      unless File.exist?("#{SYNC}/.gem/#{gem_project}")
        Dir.mkdir("#{SYNC}/.gem/#{gem_project}")
        system <<-CMD
          cd #{SYNC}/.gem/#{gem_project};
          git clone #{ANNEX}/.gem/#{gem_project}.git;
        CMD
      end
    end
  end
end

update = Annex.new
update.sync
