#!/usr/bin/ruby -w
# annex.rb
# Author: Andy Bettisworth
# Description: Annex local ~/.sync files

require 'fileutils'

class Annex
  ANNEX_SYNC = "/media/#{ENV['USER']}/Village/preseed/.seed-install/.sync"
  LOCAL_SYNC = "#{ENV['HOME']}/.sync"
  SYNC_REPOSITORIES = [
    '.canvas',
    '.script',
    '.template',
    '.todo',
    '.preseed'
  ]
  SYNC_APPLICATIONS = [
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
    require_annex_usb
    SYNC_REPOSITORIES.each { |r| sync(r) }
    SYNC_APPLICATIONS.each { |a| sync(a, '.app/') }
    SYNC_GEMS.each { |g| sync(g, '.gem/') }
  end

  private

  def require_annex_usb
    raise 'USBNotFound!' unless File.exist?(ANNEX_SYNC)
  end

  def sync(repo, subdir='')
    local_repo  = "#{LOCAL_SYNC}/#{subdir}#{repo}"
    annex_repo  = "#{ANNEX_SYNC}/#{subdir}#{repo}.git"
    remote_path = "file://#{ANNEX_SYNC}/#{subdir}#{repo}.git"

    ensure_local_repo_exists(local_repo)
    ensure_annex_repo_exists(annex_repo)
    ensure_branch_exists(local_repo, 'annex')
    ensure_remote_branch_exists(local_repo, 'origin', remote_path)

    commit_local(local_repo)
    sync_upstream(local_repo)
  end

  def ensure_local_repo_exists(path)
    unless File.exist?(path)
      create_repo(path)
      Dir.chdir path
      system <<-CMD
        touch .keep;
        git init;
        git add -A;
        git commit -m 'init';
        git checkout -b annex;
      CMD
    end
  end

  def ensure_annex_repo_exists(path)
    unless File.exist?(path)
      create_repo(path)
      Dir.chdir path
      system 'git init --bare;'
    end
  end

  def create_repo(path)
    puts <<-MSG

  No repository found at #{path}
  Creating repository...

    MSG
    FileUtils.mkdir_p path
  end

  def ensure_branch_exists(repo, branch)
    unless branch_exist?(repo, branch)
      puts <<-MSG

  #{branch} branch missing for #{repo}"
  Creating #{branch} branch...

      MSG
      Dir.chdir repo

      system <<-CMD
      git add -A;
      git stash save;
      git stash drop;
      git checkout -b #{branch};
      CMD
    end
  end

  def branch_exist?(repo, branch)
    Dir.chdir repo
    branches = `git branch`
    return branches.include?(branch)
  end

  def ensure_remote_branch_exists(local_repo, remote_branch, remote_path)
    unless remote_exist?(local_repo, remote_branch)
      puts <<-MSG

  #{remote_branch} remote branch missing for #{local_repo}"
  Creating remote branch #{remote_branch}...

      MSG
      Dir.chdir local_repo

      system <<-CMD
        git remote add #{remote_branch} #{remote_path};
      CMD
    end
  end

  def remote_exist?(path, remote_branch)
    Dir.chdir path
    remotes = `git remote -v`
    return remotes.include?(remote_branch)
  end

  def commit_local(local_repo)
    puts <<-MSG

  #{local_repo}

  saving any local changes...
    MSG
    Dir.chdir local_repo

    system <<-CMD
      git checkout annex;
      git add -A;
      git commit -m "annex-#{Time.now.strftime('%Y%m%d%H%M%S')}";
    CMD
  end

  def sync_upstream(local_repo)
    puts "  syncing upstream changes..."
    Dir.chdir local_repo

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

## USAGE
update = Annex.new
update.start
