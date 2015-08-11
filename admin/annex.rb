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
    LOCAL  = File.join(HOME, 'GitHub')

    def sync
      'Syncing with github...'
      @is_windows = (ENV['OS'] == 'Windows_NT')

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
      entries = Dir.glob(File.join(local_path, '*')).reject do |x|
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
      system 'git checkout --quiet -b annex'
      system 'git checkout --quiet annex'
      system 'git add -A'
      system %q{ git commit -m "annex-#{Time.now.strftime('%Y%m%d%H%M%S')}"'}
    end

    def push_remote
      system 'git checkout --quiet -b master'
      system 'git checkout --quiet master'
      system 'git pull --no-edit origin master'
      system 'echo'
      system 'git checkout --quiet annex'
      system 'echo "Rebasing annex onto master..."'
      system 'git rebase master'
      system 'echo'
      system 'git checkout --quiet master'
      system 'echo "Merging annex with master..."'
      system 'git merge --no-edit annex'
      system 'echo'
      system 'echo "Pushing master to remote origin..."'
      system 'git push origin master'
      system 'git checkout --quiet annex'
      system 'git merge  --quiet --no-edit master'
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
