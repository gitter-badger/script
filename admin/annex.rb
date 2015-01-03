#!/usr/bin/ruby -w
# annex.rb
# Author: Andy Bettisworth
# Description: Annex thy code repositories both public and private

require 'optparse'
require 'fileutils'
require 'open3'

class Annex
  GITHUB_REMOTE = "https://www.github.com"
  GITLAB_REMOTE = "http://localhost:8080"

  GITHUB_LOCAL  = "#{ENV['HOME']}/GitHub"
  GITLAB_LOCAL  = "#{ENV['HOME']}/GitLab"

  attr_accessor :user
  attr_accessor :github_repos
  attr_accessor :gitlab_repos

  def initialize(user='wurde')
    @user = user
    @github_repos = get_local_github_repos
    @gitlab_repos = get_local_gitlab_repos
  end

  def github
    puts "Syncing with #{GITHUB_REMOTE}/#{@user}..."

    @github_repos.each do |repo|
      local_repo  = "#{GITHUB_LOCAL}/#{repo}"
      remote_repo = "#{GITHUB_REMOTE}/#{@user}/#{repo}.git"

      print_target_repo(repo)
      next if remote_exist?(remote_repo) == false
      sync_changes(local_repo, remote_repo)
    end
  end

  def gitlab
    puts "Syncing with #{GITLAB_REMOTE}/#{@user}..."

    @gitlab_repos.each do |repo|
      local_repo  = "#{GITLAB_LOCAL}/#{repo}"
      remote_repo = "#{GITLAB_REMOTE}/#{@user}/#{repo}.git"

      print_target_repo(repo)
      next if remote_exist?(remote_repo) == false
      sync_changes(local_repo, remote_repo)
    end
  end

  private

  def sync_changes(local_repo, remote_repo)
    puts '  Success!'
    # commit_local(local_repo)
    # push_remote(local_repo)
  end

  def remote_exist?(remote_repo)
    stdin, stdout, stderr, status = Open3.popen3("wget --server-response --max-redirect=0 #{remote_repo}")
    stdout.gets(nil)
    stdout.close
    stderr.gets(nil)
    stderr.close
    exit_code = status.value.exitstatus

    case exit_code
    when 0
      return true
    when 4
      puts "  NetworkError: oops, something went wrong."
    when 6
      puts "  UserPassError: : oops, something went wrong."
    when 8
      puts "  ServerError: oops, something went wrong."
    else
      puts "  UnknownError: oops, something went wrong."
    end

    return false
  end

  def throw_missing_repo(repo)
    puts "MisingRepositoryError: No git repository available at '#{repo}'"
  end

  def print_target_repo(repo)
    puts <<-MSG

### #{repo}

    MSG
  end

  def commit_local(local_repo)
    puts "  saving any open changes on local repo..."
    Dir.chdir local_repo

    system <<-CMD
      git checkout annex;
      git add -A;
      git commit -m "annex-#{Time.now.strftime('%Y%m%d%H%M%S')}";
    CMD
  end

  def push_remote(local_repo)
    puts "  pushing changes to remote repo..."
    Dir.chdir local_repo

    system <<-CMD
      git checkout master;
      git pull --no-edit origin master;
      git checkout annex;
      git rebase master;
      git checkout master;
      git merge --no-edit annex;
      git push origin master;
      git checkout annex;
      git merge --no-edit master
    CMD
  end

  def get_local_github_repos
    Dir.entries(GITHUB_LOCAL).reject! {|x| x == '.' or x == '..'}
  end

  def get_local_gitlab_repos
    Dir.entries(GITLAB_LOCAL).reject! {|x| x == '.' or x == '..'}
  end
end

if __FILE__ == $0
  options = {}
  option_parser = OptionParser.new do |opts|
    opts.banner = 'USAGE: annex [options]'

    opts.on('--github', 'Annex the public github repositories') do
      options[:github] = true
    end

    opts.on('--gitlab', 'Annex the private gitlab repositories') do
      options[:gitlab] = true
    end
  end
  option_parser.parse!

  update = Annex.new

  if options[:github]
    update.github
    exit
  elsif options[:gitlab]
    update.gitlab
    exit
  end

  puts option_parser
end