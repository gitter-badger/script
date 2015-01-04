#!/usr/bin/env ruby
# app.rb
# Author: Andy Bettisworth
# Created At: 2015 0103 163526
# Modified At: 2015 0103 163526
# Description: CLI-Application for App Management

require 'optparse'

class Application
  GITHUB_LOCAL  = "#{ENV['HOME']}/GitHub"
  GITLAB_LOCAL  = "#{ENV['HOME']}/GitLab"

  def list(app_regexp=false)
    github_apps = get_github_apps
    gitlab_apps = get_gitlab_apps

    github_apps = filter_apps(github_apps, app_regexp)
    gitlab_apps = filter_apps(gitlab_apps, app_regexp)

    puts <<-MSG

GitHub Applications (public)

    MSG
    github_apps.each {|a| puts "  #{a}"}

    puts <<-MSG

GitLab Applications (private)

    MSG
    gitlab_apps.each {|a| puts "  #{a}"}
  end

  def fetch(*apps)
    apps = ask_for_app while apps.flatten.empty?
    apps = get_app_location(apps)
    # puts apps.inspect
    # move_apps_to_desktop(apps)
  end

  def clean
    github_apps = get_github_apps
    gitlab_apps = get_gitlab_apps

    github_apps_out = get_open_apps(github_apps)
    gitlab_apps_out = get_open_apps(gitlab_apps)
    # > .. = get_app_location(..)

    # if scripts_out
    #   if scripts_out.is_a? Array
    #     scripts_out.each { |s| system("mv #{HOME}/Desktop/#{File.basename(s)} #{s}") }
    #   else
    #     system("mv #{HOME}/Desktop/#{File.basename(scripts_out)} #{scripts_out}")
    #   end

    #   # > commit_changes
    # end
  end

  private

  def get_app_location(*apps)
    github_apps = get_github_apps
    gitlab_apps = get_gitlab_apps

    print apps.inspect
    apps.flatten!
    print apps.inspect
    # apps.collect! do |app|
    #   puts "Searching for #{app}"
    #   is_github = true if github_apps.include?(app)
    #   is_gitlab = true if gitlab_apps.include?(app)

    #   if is_github and is_gitlab
    #     puts "  Duplicate repositories in both GitLab and GitHub for '#{app}'"
    #     next
    #   elsif is_github
    #     return "#{GITHUB_LOCAL}/#{app}"
    #   elsif is_gitlab
    #     return "#{GITLAB_LOCAL}/#{app}"
    #   else
    #     next
    #   end
    # end

    apps
  end

  def move_apps_to_desktop(*apps)
    apps.flatten!
    apps.each do |app|
      if File.exist?(app)
        system("cp #{app} #{HOME}/Desktop")
      else
        puts "NotFoundError: could not find '#{app}'"
      end
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
    Dir.entries(GITHUB_LOCAL).reject! {|x| x == '.' or x == '..'}
  end

  def get_gitlab_apps
    Dir.entries(GITLAB_LOCAL).reject! {|x| x == '.' or x == '..'}
  end
end

if __FILE__ == $0
  options = {}
  option_parser = OptionParser.new do |opts|
    opts.banner = "Usage: app [options] [APPLICATION]"

    opts.on('-l [REGXP]', '--list [REGXP]', 'List all matching applications') do |regexp|
      options[:list] = true
      options[:list_pattern] = regexp
    end

    opts.on('-f', '--fetch', 'Copy application(s) to the Desktop') do
      options[:fetch] = true
    end

    opts.on('--clean', 'Move application(s) off Desktop and commit changes') do
      options[:clean] = true
    end
  end
  option_parser.parse!

  mgr = Application.new

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