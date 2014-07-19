#!/usr/bin/ruby -w
# annex.rb
# Author: Andy Bettisworth
# Description: Sync my Annex with Village USB

require 'fileutils'

class Annex
  HOME            = ENV['HOME']
  ANNEX_SYNC_PATH = "/media/Village/preseed/seed/.sync"
  LOCAL_SYNC_PATH = "#{HOME}/.sync"
  SYNC_REPOSITORY = [
    '.canvas',
    '.script',
    '.template',
    '.todo'
  ]
  SYNC_APPLICATIONS    = [
    'developer_training',
    'accreu'
  ]
  SYNC_GEMS = [
    'scrapyard',
    'tribe_triage',
    'phantom_assembly',
    'tandem_feet',
    'collective_vibration'
  ]

  def start
    require_annex

    SYNC_REPOSITORY.each do |r|
      sync "#{LOCAL_SYNC_PATH}/#{r}"
    end

    SYNC_APPLICATIONS.each do |a|
      sync "#{LOCAL_SYNC_PATH}/.app/#{a}"
    end

    SYNC_GEMS.each do |g|
      sync "#{LOCAL_SYNC_PATH}/.gem/#{g}"
    end
  end

  private

  def require_annex
    raise 'VillageUSBNotFound!' unless File.exist?(ANNEX_SYNC_PATH)
  end

  def sync(repo)
    ensure_repository_exist(repo)
    ensure_annex_branch_exist(repo)
    ensure_origin_remote(repo)
    commit_local(repo)
    sync_upstream(repo)
  end

  def ensure_repository_exist(repo)
    unless File.exist?(repo)
      puts <<-MSG

  No repository found at #{repo}
  Creating repository...

      MSG
      FileUtils.mkdir_p repo
      Dir.chdir repo

      system <<-CMD
      git init;
      git add -A;
      git commit -m 'init';
      CMD
    end
  end

  def ensure_annex_branch_exist(repo)
    unless branch_exist?(repo, 'annex')
      puts <<-MSG

  annex branch missing for #{repo}"
  Creating annex branch...

      MSG
      Dir.chdir repo

      system <<-CMD
      git add -A;
      git stash save;
      git stash drop;
      git checkout -b annex;
      CMD
    end
  end

  def branch_exist?(repo, branch)
    Dir.chdir repo
    branches = `git branch`
    return branches.include?(branch)
  end

  def ensure_origin_remote(repo)
    unless remote_exist?(repo, 'origin')
      puts <<-MSG

  origin remote missing for #{repo}"
  Creating origin remote...

      MSG
      Dir.chdir repo

      system <<-CMD
        git remote add origin file://#{ANNEX_SYNC_PATH}/#{repo};
      CMD
    end
  end

  def remote_exist?(repo, remote)
    Dir.chdir repo
    remotes = `git remote -v`
    return remotes.include?(remote)
  end

  def commit_local(repo)
    puts <<-MSG

  #{repo}

  saving any local changes...
    MSG
    Dir.chdir repo

    system <<-CMD
      git checkout annex;
      git add -A;
      git commit -m "annex-#{Time.now.strftime('%Y%m%d%H%M%S')}";
    CMD
  end

  def sync_upstream(repo)
    puts "  syncing upstream changes..."
    Dir.chdir repo

    system <<-CMD
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
