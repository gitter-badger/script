#!/usr/bin/ruby -w
# annex.rb
# Author: Andy Bettisworth
# Description: Annex thy code repositories both public and private

require 'optparse'
require 'fileutils'

class Annex
  GITHUB = "https://www.github.com"
  GITLAB = "http://localhost:8080"

  GITHUB_REPOS = [
    'canvas',
    'script',
  ]
  GITLAB_REPOS = [
    'schema',
    'stylesheet',
  ]

  attr_accessor :user

  def initialize(user='wurde')
    @user = user
  end

  def github
    puts "Syncing GitHub..."
    # sync_github("#{LOCAL_SYNC}/.canvas")
    # sync_github("#{LOCAL_SYNC}/.script")
  end

  def gitlab
    puts "Syncing GitLab..."
    # sync_github("#{LOCAL_SYNC}/.canvas")
    # sync_github("#{LOCAL_SYNC}/.script")
  end

  private

  # def sync(repo, subdir='')
  #   local_repo  = "#{LOCAL_SYNC}/#{subdir}#{repo}"
  #   annex_repo  = "#{ANNEX_SYNC}/#{subdir}#{repo}.git"
  #   remote_path = "file://#{ANNEX_SYNC}/#{subdir}#{repo}.git"

  #   ensure_local_repo_exists(local_repo)
  #   ensure_annex_repo_exists(annex_repo)
  #   ensure_branch_exists(local_repo, 'annex')
  #   ensure_remote_branch_exists(local_repo, 'origin', remote_path)

  #   commit_local(local_repo)
  #   sync_upstream(local_repo)
  # end

  # def ensure_local_repo_exists(path)
  #   unless File.exist?(path)
  #     create_repo(path)
  #     Dir.chdir path
  #     system <<-CMD
  #       touch .keep;
  #       git init;
  #       git add -A;
  #       git commit -m 'init';
  #       git checkout -b annex;
  #     CMD
  #   end
  # end

  # def ensure_annex_repo_exists(path)
  #   unless File.exist?(path)
  #     create_repo(path)
  #     Dir.chdir path
  #     system 'git init --bare;'
  #   end
  # end

  # def create_repo(path)
  #   puts <<-MSG

  # No repository found at #{path}
  # Creating repository...

  #   MSG
  #   FileUtils.mkdir_p path
  # end

  # def ensure_branch_exists(repo, branch)
  #   unless branch_exist?(repo, branch)
  #     puts <<-MSG

  # #{branch} branch missing for #{repo}"
  # Creating #{branch} branch...

  #     MSG
  #     Dir.chdir repo

  #     system <<-CMD
  #     git add -A;
  #     git stash save;
  #     git stash drop;
  #     git checkout -b #{branch};
  #     CMD
  #   end
  # end

  # def branch_exist?(repository, branch)
  #   Dir.chdir repository
  #   branches = `git branch`
  #   return branches.include?(branch)
  # end

  # def ensure_remote_branch_exists(local_repo, remote_branch, remote_path)
  #   unless remote_exist?(local_repo, remote_branch)
  #     puts <<-MSG

  # #{remote_branch} remote branch missing for #{local_repo}"
  # Creating remote branch #{remote_branch}...

  #     MSG
  #     Dir.chdir local_repo

  #     system <<-CMD
  #       git remote add #{remote_branch} #{remote_path};
  #     CMD
  #   end
  # end

  # def remote_exist?(repository, branch)
  #   Dir.chdir repository
  #   remotes = `git remote -v`
  #   return remotes.include?(branch)
  # end

  # def commit_local(local_repo)
  #   puts <<-MSG

  # #{local_repo}

  # saving any local changes...
  #   MSG
  #   Dir.chdir local_repo

  #   system <<-CMD
  #     git checkout annex;
  #     git add -A;
  #     git commit -m "annex-#{Time.now.strftime('%Y%m%d%H%M%S')}";
  #   CMD
  # end

  # def sync_upstream(local_repo)
  #   puts "  syncing upstream changes..."
  #   Dir.chdir local_repo

  #   system <<-CMD
  #     git checkout master;
  #     git pull origin master;
  #     git checkout annex;
  #     git rebase master;
  #     git checkout master;
  #     git merge annex;
  #     git push origin master;
  #     git checkout annex;
  #   CMD
  # end

  # def sync_github(repo_path)
  #   raise "MissingBranch: No branch named 'master'" unless branch_exist?(repo_path, 'master')
  #   raise "MissingBranch: No branch named 'annex'" unless branch_exist?(repo_path, 'annex')
  #   raise "MissingBranch: No remote named 'github'" unless remote_exist?(repo_path, 'github')
  #   system <<-CMD
  #     cd #{repo_path}
  #     git checkout master
  #     git merge annex
  #     git pull --no-edit github master
  #     git push github master
  #     git checkout annex
  #     git merge --no-edit master
  #   CMD
  # end
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