#!/usr/bin/ruby -w
# annex.rb
# Author: Andy Bettisworth
# Description: Sync [.script, .canvas, .template, .rbenv] with Annex

require 'optparse'

class Annex
  HOME = ENV['HOME']
  SYNC = "#{ENV['HOME']}/.sync"
  ANNEX = "/media/Annex/preseed/seed/.sync"
  APPS = ['accreu', 'tribetriage']
  GEMS = ['tribe_triage','collective_vibration','phantom_assembly','tandem_feet']

  def sync
    raise 'Annex not found.' unless File.exist?(ANNEX)
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
    APPS.each do |application|
      system <<-EOF
        echo '';
        echo "syncing APP: #{application}";
        cd #{SYNC}/.app/#{application};
        git add -u;
        git commit -m "annex-#{Time.now.strftime('%Y%m%d%H%M%S')}";
      EOF
    end
    GEMS.each do |gem_project|
      system <<-EOF
        echo '';
        echo "syncing APP: #{gem_project}";
        cd #{SYNC}/.gem/#{gem_project};
        git add -u;
        git commit -m "annex-#{Time.now.strftime('%Y%m%d%H%M%S')}";
      EOF
    end
  end

  private

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
end

update = Annex.new
update.sync
