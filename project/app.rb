#!/usr/bin/env ruby
# app.rb
# Author: Andy Bettisworth
# Created At: 2015 0103 163526
# Modified At: 2015 0103 163526
# Description: Manage local applications

$LOAD_PATH.push File.expand_path('../../', __FILE__)

require 'admin/admin'
require 'project/project'

module Project
  # manage all local applications
  class ApplicationManager
    include Admin

    GITHUB_LOCAL = File.join(HOME, 'GitHub')
    GITLAB_LOCAL = File.join(HOME, 'GitLab')

    def list(app_regexp = false)
      github_apps = get_github_apps
      gitlab_apps = get_gitlab_apps
      github_apps = filter_apps(github_apps, app_regexp)
      gitlab_apps = filter_apps(gitlab_apps, app_regexp)

      puts <<-MSG

  GitHub Applications (public)

      MSG
      github_apps.each { |a| puts "  #{a}" }

      puts <<-MSG

  GitLab Applications (private)

      MSG
      gitlab_apps.each { |a| puts "  #{a}" }
    end

    def fetch(*apps)
      apps = ask_for_app while apps.flatten.empty?
      apps = get_app_location(apps)
      move_apps_to_desktop(apps)
    end

    def clean
      open_apps = get_open_apps

      if open_apps
        if open_apps.is_a? Array
          open_apps.each do |app|
            FileUtils.rm_rf(app)
            FileUtils.mv(File.join(HOME, 'Desktop', File.basename(app)), app)
          end
        else
          FileUtils.rm_rf(open_apps)
          FileUtils.mv(File.join(HOME, 'Desktop', File.basename(open_apps)), open_apps)
        end
      end
    end

    private

    def get_open_apps
      open_apps = []

      github_apps = get_github_apps
      gitlab_apps = get_gitlab_apps

      Dir.glob(File.join(DESKTOP, '*')) do |entry|
        next if entry == '.' or entry == '..'

        filename = File.basename(entry)
        is_github = true if github_apps.include?(filename)
        is_gitlab = true if gitlab_apps.include?(filename)

        if is_github and is_gitlab
          next
        elsif is_github
          puts "  Cleaning GitHub application '#{filename}'..."
          open_apps << File.join(GITHUB_LOCAL, filename)
        elsif is_gitlab
          puts "  Cleaning GitLab application '#{filename}'..."
          open_apps << File.join(GITLAB_LOCAL, filename)
        else
          next
        end
      end

      open_apps
    end

    def get_app_location(*apps)
      github_apps = get_github_apps
      gitlab_apps = get_gitlab_apps

      apps.flatten!
      apps.collect! do |app|
        is_github = true if github_apps.include?(app)
        is_gitlab = true if gitlab_apps.include?(app)

        if is_github and is_gitlab
          puts "  WARNING: found #{app} in both GitHub and GitLab"
          app = nil
        elsif is_github
          app = File.join(GITHUB_LOCAL, app)
        elsif is_gitlab
          app = File.join(GITLAB_LOCAL, app)
        else
          puts "  WARNING: could not find application named '#{app}'"
          app = nil
        end

        app
      end
      apps = apps.compact

      apps
    end

    def move_apps_to_desktop(*apps)
      apps.flatten!
      apps.each do |app|
        if File.exist?(app)
          puts <<-MSG

    Fetching the application '#{File.basename(app)}'...
          MSG
          FileUtils.rm_rf(File.join(HOME, 'Desktop', File.basename(app)))
          FileUtils.cp_r(app, DESKTOP)
        else
          puts "NotFoundError: could not find '#{File.basename(app)}'"
        end
        puts '  Success!'
      end
    end

    def ask_for_app
      puts "What app do you want?"
      apps = gets.split(/\s.*?/).flatten
      apps
    end

    def filter_apps(apps, app_regexp=false)
      pattern = Regexp.new(app_regexp) if app_regexp
      apps.select! { |a| pattern.match(a) } if pattern
      apps
    end

    def get_github_apps
      entries = []
      Dir.glob(File.join(GITHUB_LOCAL, '*')).each do |entry|
        entries << File.basename(entry)
      end
      entries
    end

    def get_gitlab_apps
      entries = []
      Dir.glob(File.join(GITLAB_LOCAL, '*')).each do |entry|
        entries << File.basename(entry)
      end
      entries
    end
  end
end

if __FILE__ == $PROGRAM_NAME
  include Project
  require 'optparse'

  options = {}
  option_parser = OptionParser.new do |opts|
    opts.banner = 'Usage: app [options] APPLICATION'

    opts.on('-l [REGXP]', '--list [REGXP]', 'List all matching applications') do |regexp|
      options[:list] = true
      options[:list_pattern] = regexp
    end

    opts.on('-f', '--fetch', 'Copy application(s) to the Desktop') do
      options[:fetch] = true
    end

    opts.on('--clean', 'Move application(s) off Desktop') do
      options[:clean] = true
    end
  end
  option_parser.parse!

  mgr = ApplicationManager.new

  if options[:list]
    mgr.list(options[:list_pattern])
  elsif options[:fetch]
    mgr.fetch(ARGV)
  elsif options[:clean]
    mgr.clean
  else
    puts option_parser
  end
end
