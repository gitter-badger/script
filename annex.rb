#!/usr/bin/ruby -w
# annex.rb
# Author: Andy Bettisworth
# Description: Annex local ~/.sync files

require 'optparse'
require 'fileutils'

class Annex
  GITHUB = "https://www.github.com/wurde"
  ANNEX_SYNC = "/media/#{ENV['USER']}/Village/preseed/.seed-install/.sync"
  LOCAL_SYNC = "#{ENV['HOME']}/.sync"
  SYNC_REPOSITORIES = [
    '.canvas',
    '.script',
    '.template',
    '.project',
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

  def full
    require_annex_usb
    SYNC_REPOSITORIES.each { |r| sync(r) }
    SYNC_APPLICATIONS.each { |a| sync(a, '.app/') }
    SYNC_GEMS.each { |g| sync(g, '.gem/') }
  end

  def slim
    require_annex_usb
    sync('.canvas')
    sync('.script')
    sync('.project')
  end

  def github
    sync_github("#{LOCAL_SYNC}/.canvas")
    sync_github("#{LOCAL_SYNC}/.script")
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

  def branch_exist?(repository, branch)
    Dir.chdir repository
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

  def remote_exist?(repository, branch)
    Dir.chdir repository
    remotes = `git remote -v`
    return remotes.include?(branch)
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

  def sync_github(local)
    raise "MissingBranch: No branch named 'master'" unless branch_exist?(local, 'master')
    raise "MissingBranch: No branch named 'annex'" unless branch_exist?(local, 'annex')
    raise "MissingBranch: No remote named 'github'" unless remote_exist?(local, 'github')
    system <<-CMD
      cd #{local}
      git checkout master
      git merge annex
      git pull github master
      git push github master
      git checkout annex
      git merge master
    CMD
  end
end

if __FILE__ == $0
  options = {}
  option_parser = OptionParser.new do |opts|
    opts.banner = 'USAGE: annex [options]'

    opts.on('-f', '--full', 'Annex all sync repositories') do
      options[:full] = true
    end

    opts.on('-s', '--slim', 'Annex only a select few repositories') do
      options[:slim] = true
    end

    opts.on('--github', 'Annex only a select few github repositories') do
      options[:github] = true
    end
  end
  option_parser.parse!

  update = Annex.new

  if options[:full]
    update.full
    exit
  elsif options[:slim]
    update.slim
    exit
  elsif options[:github]
    update.github
    exit
  end

  puts option_parser
end