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
    puts "Syncing GitHub #{GITHUB_REMOTE}/#{@user}...\n"
    @github_repos.each do |repo|
      print_target_repo(repo)
      sync_changes("#{GITHUB_LOCAL}/#{repo}")
    end
  end

  def gitlab
    puts "Syncing GitLab #{GITLAB_REMOTE}/#{@user}...\n"
    @gitlab_repos.each do |repo|
      print_target_repo(repo)
      sync_changes("#{GITLAB_LOCAL}/#{repo}")
    end
  end

  private

  def sync_changes(local_repo)
    Dir.chdir local_repo
    commit_local
    push_remote
  end

  def print_target_repo(repo)
    puts <<-MSG

### #{repo}

    MSG
  end

  def commit_local
    puts "  Saving open changes on local repo...\n\n"

    system <<-CMD
      git checkout -b annex;
      git add -A;
      git commit -m "annex-#{Time.now.strftime('%Y%m%d%H%M%S')}";
    CMD
  end

  def push_remote
    puts "  Pushing changes to remote repo..."

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