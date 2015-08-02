#!/usr/bin/env ruby
# annex.rb
# Author: Andy Bettisworth
# Description: Annex thy code from GitHub and GitLab

require 'fileutils'
require 'open3'

require_relative 'admin'

module Admin
  # Sync all local GitHub applications
  class Annex
    REMOTE = 'https://www.github.com'
    LOCAL  = "#{ENV['HOME']}/GitHub"

    def sync
      'Syncing with github...'
      repos = get_local_repos
      repos.each do |repo|
        print_target(repo, File.basename(repo))
        Dir.chdir repo
        commit_local
        puts
        push_remote
      end
    end

    def get_local_repos(local_path = LOCAL)
      entries = Dir.glob("#{local_path}/*/").reject do |x|
        x == '.' || x == '..'
      end
      entries
    end

    private

    def print_target(path, repo)
      puts <<-MSG

################################
### #{repo}
### #{path}

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
        git checkout --quiet annex 2> /dev/null;
        echo 'Rebasing annex onto master...';
        git rebase master;
        echo '';
        git checkout --quiet master 2> /dev/null;
        echo 'Merging annex with master...';
        git merge --no-edit annex;
        echo '';
        echo 'Pushing master to remote origin...';
        git push origin master;
        git checkout --quiet annex 2> /dev/null;
        git merge  --quiet --no-edit master 2> /dev/null;
      CMD
    end
  end
end

if __FILE__ == $PROGRAM_NAME
  require 'optparse'
  include Admin

  options = {}
  option_parser = OptionParser.new do |opts|
    opts.banner = 'USAGE: annex'
  end
  option_parser.parse!

  annex = Annex.new
  annex.sync
end
