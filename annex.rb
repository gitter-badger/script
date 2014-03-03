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
    system <<-EOF
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
    EOF
  end

  def commit_local
    system <<-EOF
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
    EOF
  end

  def sync_apps
    APPS.each do |application|
      system <<-EOF
        echo '';
        echo "syncing APP: #{application}";
        cd #{SYNC}/.app/#{application};
        git add -u;
        git commit -m "annex-#{Time.now.strftime('%Y%m%d%H%M%S')}";
        git pull origin master;
        git push origin master;
      EOF
    end
  end

  def sync_gems
    GEMS.each do |gem_project|
      system <<-EOF
        echo '';
        echo "syncing GEM: #{gem_project}";
        cd #{SYNC}/.gem/#{gem_project};
        git add -u;
        git commit -m "annex-#{Time.now.strftime('%Y%m%d%H%M%S')}";
        git pull origin master;
        git push origin master;
      EOF
    end
  end

  def ensure_repositories
    APPS.each do |application|
      unless File.exist?("#{SYNC}/.app/#{application}")
        puts "missing dir: #{application}"
      end
    end
    GEMS.each do |gem_project|
      unless File.exist?("#{SYNC}/.gem/#{gem_project}")
        puts "missing dir: #{gem_project}"
      end
    end
  end
end

update = Annex.new
update.sync
