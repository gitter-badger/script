#!/usr/bin/env ruby
# annex.rb
# Author: Andy Bettisworth
# Description: Annex thy code from GitHub and GitLab

require 'optparse'
require 'fileutils'
require 'open3'

module Annex
  class Base
    attr_accessor :scope
    attr_accessor :remote
    attr_accessor :local

    def sync
      puts @scope
      repos = get_local_repos
      repos.each do |repo|
        print_target(repo, File.basename(repo))
        Dir.chdir repo
        commit_local
        puts
        push_remote
      end
    end

    def get_local_repos(local_path=@local)
      entries = Dir.glob("#{local_path}/*/").reject {|x| x == '.' or x == '..'}
      entries
    end

    private

    def print_target(path, repo)
      puts <<-MSG

################################
# ## ### #{repo} - #{path}
      MSG
    end

    def commit_local
      system <<-CMD
        git checkout --quiet -b annex 2> /dev/null;
        git checkout --quiet annex 2> /dev/null;
        git add -A 2> /dev/null;
        git commit -m "annex-#{Time.now.strftime('%Y%m%d%H%M%S')}";
      CMD
    end

    def push_remote
      system <<-CMD
        git checkout --quiet -b master 2> /dev/null;
        git checkout --quiet master 2> /dev/null;
        git pull --no-edit origin master;
        echo '';
        git checkout annex 2> /dev/null;
        echo 'Rebasing annex onto master...';
        git rebase master;
        echo '';
        git checkout master 2> /dev/null;
        echo 'Merging annex with master...';
        git merge --no-edit annex;
        echo '';
        echo 'Pushing master to remote origin...';
        git push origin master;
        git checkout annex 2> /dev/null;
        git merge  --quiet --no-edit master 2> /dev/null;
      CMD
    end
  end

  class GitHub < Annex::Base
    def initialize
      @scope  = 'syncing github...'
      @remote = "https://www.github.com"
      @local  = "#{ENV['HOME']}/GitHub"
    end

    def sync
      super
    end
  end

  class GitLab < Annex::Base
    def initialize
      @scope  = 'syncing gitlab...'
      @remote = "http://localhost:8080"
      @local  = "#{ENV['HOME']}/GitLab"
    end

    def sync
      super
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