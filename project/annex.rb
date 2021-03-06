#!/usr/bin/env ruby
# annex.rb
# Author: Andy Bettisworth
# Description: Annex thy code from GitHub and GitLab

require 'fileutils'
require 'open3'

$LOAD_PATH.push File.expand_path('../../', __FILE__)

require 'admin/admin'
require 'project/project'

module Project
  # Sync all local GitHub applications
  class Annex
    include Admin

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
      if @is_windows
        system 'git checkout --quiet -b annex > NUL'
        system 'git checkout --quiet annex > NUL'
      else
        system 'git checkout --quiet -b annex 2> /dev/null'
        system 'git checkout --quiet annex 2> /dev/null'
      end

      system 'git add -A'
      system %q{ git commit -m "annex-#{Time.now.strftime('%Y%m%d%H%M%S')}"'}
    end

    def push_remote
      if @is_windows
        system 'git checkout --quiet -b master > NUL'
        system 'git checkout --quiet master > NUL'
      else
        system 'git checkout --quiet -b master 2> /dev/null'
        system 'git checkout --quiet master 2> /dev/null'
      end

      system 'git pull --no-edit origin master'
      system 'echo'

      if @is_windows
        system 'git checkout --quiet annex > NUL'
      else
        system 'git checkout --quiet annex 2> /dev/null'
      end

      system 'echo "Rebasing annex onto master..."'
      system 'git rebase master'
      system 'echo'

      if @is_windows
        system 'git checkout --quiet master > NUL'
      else
        system 'git checkout --quiet master 2> /dev/null'
      end

      system 'echo "Merging annex with master..."'
      system 'git merge --no-edit annex'
      system 'echo'
      system 'echo "Pushing master to remote origin..."'
      system 'git push origin master'

      if @is_windows
        system 'git checkout --quiet annex > NUL'
      else
        system 'git checkout --quiet annex 2> /dev/null'
      end

      system 'git merge --quiet --no-edit master'
    end
  end
end

if __FILE__ == $PROGRAM_NAME
  include Project
  require 'optparse'

  options = {}
  option_parser = OptionParser.new do |opts|
    opts.banner = 'USAGE: annex'
  end
  option_parser.parse!

  annex = Annex.new
  annex.sync
end
