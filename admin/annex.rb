#!/usr/bin/env ruby
# annex.rb
# Author: Andy Bettisworth
# Description: Annex thy code from GitHub and GitLab

require 'optparse'
require 'fileutils'
require 'open3'

module Annex
  class Base
    attr_accessor :user
    attr_accessor :github_repos
    attr_accessor :gitlab_repos

    def initialize(user='wurde')
      @user = user
      @github_repos = get_local_github_repos
      @gitlab_repos = get_local_gitlab_repos
    end

    def github
      puts "Syncing with GitHub #{GITHUB_REMOTE}/#{@user}...\n"
      if @github_repos
        @github_repos.each do |repo|
          print_target(File.basename(repo))
          sync_changes(repo)
        end
      else
        puts "Nothing locally to sync, lame."
      end
    end

    def gitlab
      puts "Syncing with GitLab #{GITLAB_REMOTE}/#{@user}...\n"
      if @gitlab_repos
        @gitlab_repos.each do |repo|
          print_target(File.basename(repo))
          sync_changes(repo)
        end
      else
        puts "Nothing locally to sync, lame."
      end
    end

    private

    def sync_changes(local_repo)
      Dir.chdir local_repo
      commit_local
      push_remote
    end

    def print_target(repo)
      puts <<-MSG

  ### #{repo}

      MSG
    end

    def commit_local
      puts <<-MSG

    Saving open changes on local repo...

    MSG

      system <<-CMD
        git checkout -b annex;
        git add -A;
        git commit -m "annex-#{Time.now.strftime('%Y%m%d%H%M%S')}";
      CMD
    end

    def push_remote
      puts <<-MSG

    Pushing changes to remote repo...

    MSG

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
      entries = Dir.glob("#{GITHUB_LOCAL}/*/").reject {|x| x == '.' or x == '..'}
      entries
    end

    def get_local_gitlab_repos
      entries = Dir.glob("#{GITLAB_LOCAL}/*/").reject {|x| x == '.' or x == '..'}
      entries
    end
  end

  class GitHub < Annex::Base
    REMOTE = "https://www.github.com"
    LOCAL  = "#{ENV['HOME']}/GitHub"

    def sync
      puts 'syncing github...'
    end
  end

  class GitLab < Annex::Base
    REMOTE = "http://localhost:8080"
    LOCAL  = "#{ENV['HOME']}/GitLab"

    def sync
      puts 'syncing gitlab...'
    end
  end
end

if __FILE__ == $0
  options = {}
  option_parser = OptionParser.new do |opts|
    opts.banner = 'USAGE: annex [options]'

    opts.on('--github', 'Annex GitHub code repositories') do
      options[:github] = true
    end

    opts.on('--gitlab', 'Annex GitLab code repositories') do
      options[:gitlab] = true
    end
  end
  option_parser.parse!

  if options.empty?
    puts option_parser
  end

  if options[:github]
    annex = Annex::GitHub.new
    annex.sync
  end

  if options[:gitlab]
    annex = Annex::GitLab.new
    annex.sync
  end

  exit
end